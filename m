Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from userp2120.oracle.com ([156.151.31.85]:37778 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728140AbeGaTx2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 31 Jul 2018 15:53:28 -0400
Date: Tue, 31 Jul 2018 21:11:49 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: maxime.roussinbelanger@gmail.com
Cc: linux-iio@vger.kernel.org
Subject: [bug report] iio: light: introduce si1133
Message-ID: <20180731181149.bqzn7pi73d62citd@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello Maxime Roussin-Bélanger,

The patch e01e7eaf37d8: "iio: light: introduce si1133" from Jul 19,
2018, leads to the following static checker warning:

	drivers/iio/light/si1133.c:428 si1133_command()
	error: uninitialized symbol 'resp'.

drivers/iio/light/si1133.c
   384  static int si1133_command(struct si1133_data *data, u8 cmd)
   385  {
   386          struct device *dev = &data->client->dev;
   387          u32 resp;
                ^^^^^^^^
   388          int err;
   389          int expected_seq;
   390  
   391          mutex_lock(&data->mutex);
   392  
   393          expected_seq = (data->rsp_seq + 1) & SI1133_MAX_CMD_CTR;
   394  
   395          if (cmd == SI1133_CMD_FORCE)
   396                  reinit_completion(&data->completion);
   397  
   398          err = regmap_write(data->regmap, SI1133_REG_COMMAND, cmd);
   399          if (err) {
   400                  dev_warn(dev, "Failed to write command %#02hhx, ret=%d\n", cmd,
   401                           err);
   402                  goto out;
   403          }
   404  
   405          if (cmd == SI1133_CMD_FORCE) {
   406                  /* wait for irq */
   407                  if (!wait_for_completion_timeout(&data->completion,
   408                          msecs_to_jiffies(SI1133_COMPLETION_TIMEOUT_MS))) {
   409                          err = -ETIMEDOUT;
   410                          goto out;
   411                  }

Assume "cmd == SI1133_CMD_FORCE" and we don't timeout, then "resp" isn't
initialized.

   412          } else {
   413                  err = regmap_read_poll_timeout(data->regmap,
   414                                                 SI1133_REG_RESPONSE0, resp,
   415                                                 (resp & SI1133_CMD_SEQ_MASK) ==
   416                                                 expected_seq ||
   417                                                 (resp & SI1133_CMD_ERR_MASK),
   418                                                 SI1133_CMD_MINSLEEP_US_LOW,
   419                                                 SI1133_CMD_TIMEOUT_MS * 1000);
   420                  if (err) {
   421                          dev_warn(dev,
   422                                   "Failed to read command %#02hhx, ret=%d\n",
   423                                   cmd, err);
   424                          goto out;
   425                  }
   426          }
   427  
   428          if (resp & SI1133_CMD_ERR_MASK) {
                    ^^^^^^^^^^^^^^^^^^^^^^^^^^

regards,
dan carpenter
