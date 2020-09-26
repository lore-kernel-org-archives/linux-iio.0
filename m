Return-Path: <SRS0=5qmk=DD=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94788C4727F
	for <linux-iio@archiver.kernel.org>; Sat, 26 Sep 2020 10:56:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56233238EE
	for <linux-iio@archiver.kernel.org>; Sat, 26 Sep 2020 10:56:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725208AbgIZK4L (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 26 Sep 2020 06:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbgIZK4L (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 26 Sep 2020 06:56:11 -0400
X-Greylist: delayed 523 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 26 Sep 2020 03:56:11 PDT
Received: from agrajag.zerfleddert.de (agrajag.zerfleddert.de [IPv6:2a01:4f8:bc:1de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97D02C0613CE
        for <linux-iio@vger.kernel.org>; Sat, 26 Sep 2020 03:56:11 -0700 (PDT)
Received: by agrajag.zerfleddert.de (Postfix, from userid 1000)
        id D34EC5B209C2; Sat, 26 Sep 2020 12:45:54 +0200 (CEST)
Date:   Sat, 26 Sep 2020 12:45:54 +0200
From:   Tobias Jordan <kernel@cdqe.de>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: [PATCH] iio: temperature: ltc2983: fix leak of device node iterator
Message-ID: <20200926104554.GA14752@agrajag.zerfleddert.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add missing of_node_put calls for the error paths of the
for_each_available_child_of_node loop in ltc2983_parse_dt.

Thought about adding an "goto err_of_node_put" instead, but as the error
paths are quite divergent, I'm not sure if that wouldn't complicate
things.

Fixes: f110f3188e56 ("iio: temperature: Add support for LTC2983")
Signed-off-by: Tobias Jordan <kernel@cdqe.de>
---
 drivers/iio/temperature/ltc2983.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/iio/temperature/ltc2983.c b/drivers/iio/temperature/ltc2983.c
index 55ff28a0f1c7..438e0ee29025 100644
--- a/drivers/iio/temperature/ltc2983.c
+++ b/drivers/iio/temperature/ltc2983.c
@@ -1285,6 +1285,7 @@ static int ltc2983_parse_dt(struct ltc2983_data *st)
 		ret = of_property_read_u32(child, "reg", &sensor.chan);
 		if (ret) {
 			dev_err(dev, "reg property must given for child nodes\n");
+			of_node_put(child);
 			return ret;
 		}
 
@@ -1293,9 +1294,11 @@ static int ltc2983_parse_dt(struct ltc2983_data *st)
 		    sensor.chan > LTC2983_MAX_CHANNELS_NR) {
 			dev_err(dev,
 				"chan:%d must be from 1 to 20\n", sensor.chan);
+			of_node_put(child);
 			return -EINVAL;
 		} else if (channel_avail_mask & BIT(sensor.chan)) {
 			dev_err(dev, "chan:%d already in use\n", sensor.chan);
+			of_node_put(child);
 			return -EINVAL;
 		}
 
@@ -1304,6 +1307,7 @@ static int ltc2983_parse_dt(struct ltc2983_data *st)
 		if (ret) {
 			dev_err(dev,
 				"adi,sensor-type property must given for child nodes\n");
+			of_node_put(child);
 			return ret;
 		}
 
@@ -1334,12 +1338,14 @@ static int ltc2983_parse_dt(struct ltc2983_data *st)
 			st->sensors[chan] = ltc2983_adc_new(child, st, &sensor);
 		} else {
 			dev_err(dev, "Unknown sensor type %d\n", sensor.type);
+			of_node_put(child);
 			return -EINVAL;
 		}
 
 		if (IS_ERR(st->sensors[chan])) {
 			dev_err(dev, "Failed to create sensor %ld",
 				PTR_ERR(st->sensors[chan]));
+			of_node_put(child);
 			return PTR_ERR(st->sensors[chan]);
 		}
 		/* set generic sensor parameters */
-- 
2.20.1

