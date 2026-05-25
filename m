Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BDA93DB994;
	Mon, 25 May 2026 08:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779697226; cv=none; b=UuQP/H4RZLeNBAly5r2VqBS1b3Ue/DNQ/qTmA17pKG7Dy/lGN8c7DPoSDZNTDAyBBpqesePoIU3zHf2uGKM10i8LcYk0j9Wy+IicTJAYs1lGIP3cC9P4/LA2c4XKPa2M6fzkESF14/9tpYI8+BDgK/pVIUYgHQh0uhbr5/gASP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779697226; c=relaxed/simple;
	bh=brgozaoIhalDjcixDFFa4XwraRRV2OwL/iJ8f3gJTIY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=crbDJGRyi6Y/VSRuiW11Z/MnlB86o1mRWAn0hEGa9nSl2sLxk58ouBl241vQmJXymmrOC7mUgE4qRbqtI8eKBQ30jAVvjCM9s8LeOjQ1deuQsWVX8uSpY08C1S7wmgtAGvZQRURMlaWqDMBKAJtDMw6pAynMDIXpVp0obN5y0zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CIJPNx7E; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CIJPNx7E"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E3F63C2BCC9;
	Mon, 25 May 2026 08:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779697225;
	bh=brgozaoIhalDjcixDFFa4XwraRRV2OwL/iJ8f3gJTIY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=CIJPNx7E7doDDJWJ0gJeeFFe+EORh1NwpJ8CdnASwQCZu7ocfAbR7w7eJgAe3RUmJ
	 NFpKrRSVAswdiSl1+5ItkmddU+4iex0RXQqdWU4m+FjbcQnLuS3bPlKpOtqXoTGyKB
	 2JPxP8AjMmyD2OvaAzdnFb3ByapvDe4ECiCgyLgeCCA/YGJphKzUDufcG9XgVSCnOB
	 p4pdocpPaj22Bx0mMYklCpoz/qukHcD9ocQoQlMk78EYN/Fm3hCzRvmDf/UNzl1srA
	 evBfburMUlzJeETAezUs/HVlMun6mPttz5A5TZkFCrfPpoJ7ogL+ggYmq+Dc6XlWbQ
	 S80L/1qUHzEtA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3B2DCD5BBF;
	Mon, 25 May 2026 08:20:25 +0000 (UTC)
From: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>
Date: Mon, 25 May 2026 10:20:17 +0200
Subject: [PATCH v4 3/8] iio: light: opt3001: ensure correct parenthesis
 alignment
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260525-opt3001-cleanup-v4-3-65b36a174f78@gmail.com>
References: <20260525-opt3001-cleanup-v4-0-65b36a174f78@gmail.com>
In-Reply-To: <20260525-opt3001-cleanup-v4-0-65b36a174f78@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Maxwell Doose <m32285159@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779697227; l=6484;
 i=joshua.crofts1@gmail.com; s=20260422; h=from:subject:message-id;
 bh=XcYPddxwQ5YRQuQYmj0mxVovELv4CpiABGttMCHtiOk=;
 b=ikYPWZZug+cctmUfGR2AXjmmj3ITWJMNMAa2Tzm6CsLaP+tGOMDJHlGZWdJ12ztg5IdgALGv2
 niuF6EktXJLD+qsYaDvb/HVNGVkD5/d0Tu+IG7yiJVq5O6tdoZm5Ka1
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=Xd+UVoRPiiI0K3LHQ2XIcXmO0jvVuFTv9eTx3lgBphI=
X-Endpoint-Received: by B4 Relay for joshua.crofts1@gmail.com/20260422 with
 auth_id=746
X-Original-From: Joshua Crofts <joshua.crofts1@gmail.com>
Reply-To: joshua.crofts1@gmail.com

From: Joshua Crofts <joshua.crofts1@gmail.com>

Ensure correct parenthesis alignment per checkpatch.pl report.

No functional change.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Maxwell Doose <m32285159@gmail.com>
Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/iio/light/opt3001.c | 73 +++++++++++++++++++++++++--------------------
 1 file changed, 41 insertions(+), 32 deletions(-)

diff --git a/drivers/iio/light/opt3001.c b/drivers/iio/light/opt3001.c
index efaad85dfaf3afc9199fd3124d832ee2a297f0b3..532929e8fa8b4172eadc696e927315017a07dac1 100644
--- a/drivers/iio/light/opt3001.c
+++ b/drivers/iio/light/opt3001.c
@@ -223,8 +223,8 @@ static const struct opt3001_scale opt3002_scales[] = {
 	},
 };
 
-static int opt3001_find_scale(const struct opt3001 *opt, int val,
-		int val2, u8 *exponent)
+static int opt3001_find_scale(const struct opt3001 *opt, int val, int val2,
+			      u8 *exponent)
 {
 	int i;
 	for (i = 0; i < ARRAY_SIZE(*opt->chip_info->scales); i++) {
@@ -242,8 +242,8 @@ static int opt3001_find_scale(const struct opt3001 *opt, int val,
 	return -EINVAL;
 }
 
-static void opt3001_to_iio_ret(struct opt3001 *opt, u8 exponent,
-		u16 mantissa, int *val, int *val2)
+static void opt3001_to_iio_ret(struct opt3001 *opt, u8 exponent, u16 mantissa,
+			       int *val, int *val2)
 {
 	int ret;
 	int whole = opt->chip_info->factor_whole;
@@ -364,8 +364,8 @@ static int opt3001_get_processed(struct opt3001 *opt, int *val, int *val2)
 	if (opt->use_irq) {
 		/* Wait for the IRQ to indicate the conversion is complete */
 		ret = wait_event_timeout(opt->result_ready_queue,
-				opt->result_ready,
-				msecs_to_jiffies(OPT3001_RESULT_READY_LONG));
+					 opt->result_ready,
+					 msecs_to_jiffies(OPT3001_RESULT_READY_LONG));
 		if (ret == 0)
 			return -ETIMEDOUT;
 	} else {
@@ -474,8 +474,8 @@ static int opt3001_set_int_time(struct opt3001 *opt, int time)
 }
 
 static int opt3001_read_raw(struct iio_dev *iio,
-		struct iio_chan_spec const *chan, int *val, int *val2,
-		long mask)
+			    struct iio_chan_spec const *chan,
+			    int *val, int *val2, long mask)
 {
 	struct opt3001 *opt = iio_priv(iio);
 	int ret;
@@ -506,8 +506,8 @@ static int opt3001_read_raw(struct iio_dev *iio,
 }
 
 static int opt3001_write_raw(struct iio_dev *iio,
-		struct iio_chan_spec const *chan, int val, int val2,
-		long mask)
+			     struct iio_chan_spec const *chan,
+			     int val, int val2, long mask)
 {
 	struct opt3001 *opt = iio_priv(iio);
 	int ret;
@@ -532,9 +532,11 @@ static int opt3001_write_raw(struct iio_dev *iio,
 }
 
 static int opt3001_read_event_value(struct iio_dev *iio,
-		const struct iio_chan_spec *chan, enum iio_event_type type,
-		enum iio_event_direction dir, enum iio_event_info info,
-		int *val, int *val2)
+				    const struct iio_chan_spec *chan,
+				    enum iio_event_type type,
+				    enum iio_event_direction dir,
+				    enum iio_event_info info,
+				    int *val, int *val2)
 {
 	struct opt3001 *opt = iio_priv(iio);
 	int ret = IIO_VAL_INT_PLUS_MICRO;
@@ -544,11 +546,13 @@ static int opt3001_read_event_value(struct iio_dev *iio,
 	switch (dir) {
 	case IIO_EV_DIR_RISING:
 		opt3001_to_iio_ret(opt, opt->high_thresh_exp,
-				opt->high_thresh_mantissa, val, val2);
+				   opt->high_thresh_mantissa,
+				   val, val2);
 		break;
 	case IIO_EV_DIR_FALLING:
 		opt3001_to_iio_ret(opt, opt->low_thresh_exp,
-				opt->low_thresh_mantissa, val, val2);
+				   opt->low_thresh_mantissa,
+				   val, val2);
 		break;
 	default:
 		ret = -EINVAL;
@@ -560,9 +564,11 @@ static int opt3001_read_event_value(struct iio_dev *iio,
 }
 
 static int opt3001_write_event_value(struct iio_dev *iio,
-		const struct iio_chan_spec *chan, enum iio_event_type type,
-		enum iio_event_direction dir, enum iio_event_info info,
-		int val, int val2)
+				     const struct iio_chan_spec *chan,
+				     enum iio_event_type type,
+				     enum iio_event_direction dir,
+				     enum iio_event_info info,
+				     int val, int val2)
 {
 	struct opt3001 *opt = iio_priv(iio);
 	struct i2c_client *client = opt->client;
@@ -626,8 +632,9 @@ static int opt3001_write_event_value(struct iio_dev *iio,
 }
 
 static int opt3001_read_event_config(struct iio_dev *iio,
-		const struct iio_chan_spec *chan, enum iio_event_type type,
-		enum iio_event_direction dir)
+				     const struct iio_chan_spec *chan,
+				     enum iio_event_type type,
+				     enum iio_event_direction dir)
 {
 	struct opt3001 *opt = iio_priv(iio);
 
@@ -635,8 +642,10 @@ static int opt3001_read_event_config(struct iio_dev *iio,
 }
 
 static int opt3001_write_event_config(struct iio_dev *iio,
-		const struct iio_chan_spec *chan, enum iio_event_type type,
-		enum iio_event_direction dir, bool state)
+				      const struct iio_chan_spec *chan,
+				      enum iio_event_type type,
+				      enum iio_event_direction dir,
+				      bool state)
 {
 	struct opt3001 *opt = iio_priv(iio);
 	struct i2c_client *client = opt->client;
@@ -812,16 +821,16 @@ static irqreturn_t opt3001_irq(int irq, void *_iio)
 			OPT3001_CONFIGURATION_M_CONTINUOUS) {
 		if (ret & OPT3001_CONFIGURATION_FH)
 			iio_push_event(iio,
-					IIO_UNMOD_EVENT_CODE(chan_type, 0,
-							IIO_EV_TYPE_THRESH,
-							IIO_EV_DIR_RISING),
-					iio_get_time_ns(iio));
+				       IIO_UNMOD_EVENT_CODE(chan_type, 0,
+							    IIO_EV_TYPE_THRESH,
+							    IIO_EV_DIR_RISING),
+				       iio_get_time_ns(iio));
 		if (ret & OPT3001_CONFIGURATION_FL)
 			iio_push_event(iio,
-					IIO_UNMOD_EVENT_CODE(chan_type, 0,
-							IIO_EV_TYPE_THRESH,
-							IIO_EV_DIR_FALLING),
-					iio_get_time_ns(iio));
+				       IIO_UNMOD_EVENT_CODE(chan_type, 0,
+							    IIO_EV_TYPE_THRESH,
+							    IIO_EV_DIR_FALLING),
+				       iio_get_time_ns(iio));
 	} else if (ret & OPT3001_CONFIGURATION_CRF) {
 		ret = i2c_smbus_read_word_swapped(client, OPT3001_RESULT);
 		if (ret < 0) {
@@ -884,8 +893,8 @@ static int opt3001_probe(struct i2c_client *client)
 	/* Make use of INT pin only if valid IRQ no. is given */
 	if (irq > 0) {
 		ret = request_threaded_irq(irq, NULL, opt3001_irq,
-				IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
-				"opt3001", iio);
+					   IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
+					   "opt3001", iio);
 		if (ret) {
 			dev_err(dev, "failed to request IRQ #%d\n", irq);
 			return ret;

-- 
2.47.3


