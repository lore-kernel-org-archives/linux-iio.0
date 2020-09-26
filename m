Return-Path: <SRS0=5qmk=DD=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D52FC2D0A8
	for <linux-iio@archiver.kernel.org>; Sat, 26 Sep 2020 16:19:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48AE62177B
	for <linux-iio@archiver.kernel.org>; Sat, 26 Sep 2020 16:19:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729448AbgIZQTs (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 26 Sep 2020 12:19:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728017AbgIZQTs (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 26 Sep 2020 12:19:48 -0400
Received: from agrajag.zerfleddert.de (agrajag.zerfleddert.de [IPv6:2a01:4f8:bc:1de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56D16C0613CE;
        Sat, 26 Sep 2020 09:19:48 -0700 (PDT)
Received: by agrajag.zerfleddert.de (Postfix, from userid 1000)
        id AFB4C5B2057C; Sat, 26 Sep 2020 18:19:46 +0200 (CEST)
Date:   Sat, 26 Sep 2020 18:19:46 +0200
From:   Tobias Jordan <kernel@cdqe.de>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>
Cc:     Marek Vasut <marek.vasut@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: [PATCH v2] iio: adc: gyroadc: fix leak of device node iterator
Message-ID: <20200926161946.GA10240@agrajag.zerfleddert.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add missing of_node_put calls when exiting the for_each_child_of_node
loop in rcar_gyroadc_parse_subdevs early.

Also add goto-exception handling for the error paths in that loop.

Fixes: 059c53b32329 ("iio: adc: Add Renesas GyroADC driver")
Signed-off-by: Tobias Jordan <kernel@cdqe.de>
---
v2:
- added an of_node_put to the non-error "break" at the end
- used gotos for the error cases, doesn't look as bad as I thought

 drivers/iio/adc/rcar-gyroadc.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/rcar-gyroadc.c b/drivers/iio/adc/rcar-gyroadc.c
index dcaefc108ff6..9f38cf3c7dc2 100644
--- a/drivers/iio/adc/rcar-gyroadc.c
+++ b/drivers/iio/adc/rcar-gyroadc.c
@@ -357,7 +357,7 @@ static int rcar_gyroadc_parse_subdevs(struct iio_dev *indio_dev)
 			num_channels = ARRAY_SIZE(rcar_gyroadc_iio_channels_3);
 			break;
 		default:
-			return -EINVAL;
+			goto err_e_inval;
 		}
 
 		/*
@@ -374,7 +374,7 @@ static int rcar_gyroadc_parse_subdevs(struct iio_dev *indio_dev)
 				dev_err(dev,
 					"Failed to get child reg property of ADC \"%pOFn\".\n",
 					child);
-				return ret;
+				goto err_of_node_put;
 			}
 
 			/* Channel number is too high. */
@@ -382,7 +382,7 @@ static int rcar_gyroadc_parse_subdevs(struct iio_dev *indio_dev)
 				dev_err(dev,
 					"Only %i channels supported with %pOFn, but reg = <%i>.\n",
 					num_channels, child, reg);
-				return -EINVAL;
+				goto err_e_inval;
 			}
 		}
 
@@ -391,7 +391,7 @@ static int rcar_gyroadc_parse_subdevs(struct iio_dev *indio_dev)
 			dev_err(dev,
 				"Channel %i uses different ADC mode than the rest.\n",
 				reg);
-			return -EINVAL;
+			goto err_e_inval;
 		}
 
 		/* Channel is valid, grab the regulator. */
@@ -401,7 +401,8 @@ static int rcar_gyroadc_parse_subdevs(struct iio_dev *indio_dev)
 		if (IS_ERR(vref)) {
 			dev_dbg(dev, "Channel %i 'vref' supply not connected.\n",
 				reg);
-			return PTR_ERR(vref);
+			ret = PTR_ERR(vref);
+			goto err_of_node_put;
 		}
 
 		priv->vref[reg] = vref;
@@ -425,8 +426,10 @@ static int rcar_gyroadc_parse_subdevs(struct iio_dev *indio_dev)
 		 * attached to the GyroADC at a time, so if we found it,
 		 * we can stop parsing here.
 		 */
-		if (childmode == RCAR_GYROADC_MODE_SELECT_1_MB88101A)
+		if (childmode == RCAR_GYROADC_MODE_SELECT_1_MB88101A) {
+			of_node_put(child);
 			break;
+		}
 	}
 
 	if (first) {
@@ -435,6 +438,12 @@ static int rcar_gyroadc_parse_subdevs(struct iio_dev *indio_dev)
 	}
 
 	return 0;
+
+err_e_inval:
+	ret = -EINVAL;
+err_of_node_put:
+	of_node_put(child);
+	return ret;
 }
 
 static void rcar_gyroadc_deinit_supplies(struct iio_dev *indio_dev)
-- 
2.20.1

