// imgurHandler.js

const axios = require('axios');

const getImgurData = async (imageId) => {
    try {
        let imgurData = null;
        const extensions = ['.mp4', '.png', '.jpg'];

        for (const ext of extensions) {
            const imgUrl = `https://i.imgur.com/${imageId}${ext}`;
            const headRes = await axios.head(imgUrl);
            if (headRes.status === 200) {
                const { headers } = headRes;
                imgurData = {
                    id: imageId,
                    size: headers['content-length'],
                    type: headers['content-type'],
                    url: imgUrl,
                    animated: headers['content-type'] === 'video/mp4',
                    mp4_size: headers['content-type'] === 'video/mp4' ? headers['content-length'] : undefined,
                    mp4: headers['content-type'] === 'video/mp4' ? imgUrl : undefined,
                    gifv: headers['content-type'] === 'video/mp4' ? `${imgUrl}.gifv` : undefined,
                    hls: headers['content-type'] === 'video/mp4' ? `${imgUrl}.m3u8` : undefined,
                };

                console.log(new Date(), "imgur <", "API response sent", imageId);
                break;
            } else {
                console.log(new Date(), "imgur <", "Failed to retrieve", imageId);
            }
        }

        if (!imgurData) {
            throw new Error(`Unable to find valid image for ID ${imageId}`);
        }

        return imgurData;
    } catch (error) {
        console.error('Error getting Imgur data:', error);
        throw error;
    }
};

const assembleResponse = (imgurData) => {
    const { id, size, type, url, animated, mp4_size, mp4, gifv, hls } = imgurData;
    return JSON.stringify({
        "data": {
            "id": id,
            "title": id,
            "description": id,
            "datetime": 1684893375,
            "type": type,
            "animated": animated,
            "width": 1024,
            "height": 1024,
            "size": size,
            "views": 42069,
            "bandwidth": 42069,
            "favorite": false,
            "nsfw": false,
            "has_sound": false,
            "link": 'https://apollogur.download/'+url,
            "mp4_size": mp4_size,
            "mp4": mp4 ? 'https://apollogur.download/'+mp4 : undefined,
            "gifv": gifv ? 'https://apollogur.download/'+gifv : undefined,
            "hls": hls ? 'https://apollogur.download/'+hls : undefined,
        },
        "success": true,
        "status": 200
    });
};

module.exports = {
    getImgurData,
    assembleResponse
};
