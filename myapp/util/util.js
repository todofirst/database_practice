
module.exports = {

      /**
     * 获取完整URL
     * @param {object} req - request
     * @returns
     */
    getFullUrl(req) {
      return `${req.protocol}://${req.get('Host')}${req.originalUrl}`;
  }

}