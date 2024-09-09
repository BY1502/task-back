const database = require('../database/database'); // database 모듈 불러오기

exports.getTasks = async (req, res) => {
  const userId = req.params.userId;

  try {
    const result = await database.query(
      'SELECT * FROM task WHERE userId = $1 ORDER BY created_at DESC',
      [userId]
    );
    return res.status(200).json(result.rows);
  } catch (error) {
    return res.status(500).json({ msg: 'Get Items Fail' + error });
  }
};
