Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:60546 "EHLO
	mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751487AbcAEPJc (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 5 Jan 2016 10:09:32 -0500
From: Julia Lawall <Julia.Lawall@lip6.fr>
To: Jonathan Cameron <jic23@kernel.org>
Cc: kernel-janitors@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iio: ak8975: constify ak_def structures
Date: Tue,  5 Jan 2016 15:56:42 +0100
Message-Id: <1452005802-4165-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The ak_def structures are never modified, so declare them as const.

Done with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/iio/magnetometer/ak8975.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index b13936d..9c5c9ef 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -252,7 +252,7 @@ struct ak_def {
 	u8 data_regs[3];
 };
 
-static struct ak_def ak_def_array[AK_MAX_TYPE] = {
+static const struct ak_def ak_def_array[AK_MAX_TYPE] = {
 	{
 		.type = AK8975,
 		.raw_to_gauss = ak8975_raw_to_gauss,
@@ -360,7 +360,7 @@ static struct ak_def ak_def_array[AK_MAX_TYPE] = {
  */
 struct ak8975_data {
 	struct i2c_client	*client;
-	struct ak_def		*def;
+	const struct ak_def	*def;
 	struct attribute_group	attrs;
 	struct mutex		lock;
 	u8			asa[3];

