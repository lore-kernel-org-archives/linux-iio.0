Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6ED426D19
	for <linux-iio@vger.kernel.org>; Wed, 10 Jun 2026 15:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781105848; cv=none; b=h/IMm6n2HORWgqvCsMbVxAPYM18dWSLfXH57kz9aPiz+PYp7FLNB5ocw4qals5ERQlqRIDpM+F/5O30LmidV/lGSfSB5/xGnpj7JS2hbqEXUUg19FW2h9ZKqoenbw5+fX+UmRVpW/6Wn2OFJ5sBkP/v2tM+yFFvgxKbYuyZpYJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781105848; c=relaxed/simple;
	bh=ACYM1UWyDtL4jgpZ3nymZ19GLuMJopkKpzQ2xDvEvVo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bNWCO6rOSP5jo984yUTERXY8f+DQd3v78jf1vJzWwPnI9YLPzqZq3DzyjZtqmveVj8vFrIFk0Mq8ThBh3a7VEvXuTUCPoQVWfx0JuMF1DiqnoC1PXDC/XSZd4KGnII9LvBf6YAPPNSqxpgk6PVum05HoqMkuJZOBAKdAt05CGiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KJpLv+et; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KJpLv+et"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-36bcf3d2565so4824560a91.3
        for <linux-iio@vger.kernel.org>; Wed, 10 Jun 2026 08:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781105846; x=1781710646; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cUryhAI6cJdR4niw1n9U4smT4zn+NcZxhvzFdjzHXwk=;
        b=KJpLv+et7RKZQmo+KWaczGXsCe0uVPhm2kxhgbwnzN9XkOZ39HRpLaGxOKTnWc8lNN
         RfkssHz5t1pbQJQQr/NO2bcIzJLlHPXMtYMFxQZU6jY9oInnCKvaQsR/e/l7zzl3zuwK
         TPN3ARG9+V0dDofSghqQVVxwSJ6ckSE0DJxJX90SMR8v8lIcN77M1jIws6/6cqLXaLy0
         O838t7Z16NyU7LHlEDVZyNKbkl3Mb5nz9fwCUdvelIuMgYGih946vW6kLY8ppiij0UF0
         4uENmNKOkGW+RGy+ozpcew90MdZureftSchXk9ksCH3RAnMb+0mwBd5y90ZUbO9LFBRD
         BgEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781105846; x=1781710646;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cUryhAI6cJdR4niw1n9U4smT4zn+NcZxhvzFdjzHXwk=;
        b=rrWMrjUEQKVmD+esvGeQ35XhRppl76dg0lSRQlP+RmDAmsApWDNWSXkfEx2DiJiZt4
         Eu2HrY9XlHWZtnbQN7NnDAvW27i7aDVv9W3JIj5d1wYp+o1/RQAKLlVLkwT7mWHaxexo
         timQV0IJjG8FXIBWOCn5Rn15aPu2dLJW0j1GXmvo4lVQ4c4z7RjW79wLiP8gbYrqtrBA
         BKT3YPCH1UTD0nbXKLVSakyPXK6+x4bdbrDkUo3UlIYgDex+cIKjujBPGnBVFoR2t8u5
         3Mg8kwaywcEwlgAgAwiutgMj2kAXJEjwOhT7cYVHkj/8ABFGQg0gMEkN4kKv3FEd1WYb
         RFoQ==
X-Forwarded-Encrypted: i=1; AFNElJ+GZ4JFCJ8r9xV0hWXfzi2TLXF6VqEv3HWsRwx0MH/CAMXOgjXbus5bSdCkXE8dkkvnTfgvZg94ZAY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxnYn3CoH6pkai4xN51osniZ6ORSiWYhW+l+3s0jU7Vh3YoSUe
	1J/CBa6arn6sYs504/K1hOWr2zFs5BWYGUzK/dSDR9Og+9xifDKM37Fc
X-Gm-Gg: Acq92OGnJd+J9hZWdVbW15qUYDZjQZNMDsqgAWMWkrTgfTjgjh+ueU2leLr5Ijh+smA
	NYxqcoh7/Bl2OUU6PV5CVMo47MuEPmGPYNmlkZAFdyd8PpgrXWPu5LZOa0VR9hDmn5MjplIHdA+
	iVPmnP92g7RlFLVS7VgLM8EXfTyxafhwYIhR/vD7IsnIb3rIS7D4Gp1qJA3G46tPlE0GZeM7FgF
	QShAnhyQOI/+Fyc3A6ntEpkYt9K+jDsGRKJvq9k94AYKuoo2TmjJ8Cy2WnZeNu0iRXWKru02/4n
	AxOPlKbGGwTzRP9z9TY9ij9J/6dKs9dtlSU1AzOAHfTxjn0th+kF+eYkUXWRvGWOu6igokuGu7O
	1XwrBs4Y3cZfXrD18gl7v/1Nv7wdSndqXzhqAf7vCZCguX3rxEEbE4fRA6AG+eNMg2oeL2RhRZz
	ZXoUIieNkiGa7lLK0I3GY8J/lQf2h95PtXq4RVN0aKyYH3BK455VBkUMgTlaU=
X-Received: by 2002:a17:90b:5787:b0:36b:e8b9:46a4 with SMTP id 98e67ed59e1d1-370f0284a87mr26901827a91.14.1781105845726;
        Wed, 10 Jun 2026 08:37:25 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3772e3a2c92sm127506a91.11.2026.06.10.08.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 08:37:25 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
Date: Wed, 10 Jun 2026 21:07:04 +0530
Subject: [PATCH v2 3/7] iio: light: hid-sensor-als: use u32 instead of
 unsigned
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260610-6-june-hid-iio-correct-usage-id-v2-3-c3c5f0720493@gmail.com>
References: <20260610-6-june-hid-iio-correct-usage-id-v2-0-c3c5f0720493@gmail.com>
In-Reply-To: <20260610-6-june-hid-iio-correct-usage-id-v2-0-c3c5f0720493@gmail.com>
To: Jiri Kosina <jikos@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-input@vger.kernel.org, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Sanjay Chitroda <sanjayembeddedse@gmail.com>, 
 Maxwell Doose <m32285159@gmail.com>
X-Mailer: b4 0.15.2

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

Prefer 'u32' instead of bare 'unsigned' for usage_id variable.
This matches expected callback API type and improves code clarity.

No functional change.

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Reviewed-by: Maxwell Doose <m32285159@gmail.com>
---
 drivers/iio/light/hid-sensor-als.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/light/hid-sensor-als.c b/drivers/iio/light/hid-sensor-als.c
index d72e260b8266..ae2fda8dc500 100644
--- a/drivers/iio/light/hid-sensor-als.c
+++ b/drivers/iio/light/hid-sensor-als.c
@@ -241,7 +241,7 @@ static const struct iio_info als_info = {
 
 /* Callback handler to send event after all samples are received and captured */
 static int als_proc_event(struct hid_sensor_hub_device *hsdev,
-				unsigned usage_id,
+				u32 usage_id,
 				void *priv)
 {
 	struct iio_dev *indio_dev = platform_get_drvdata(priv);
@@ -263,7 +263,7 @@ static int als_proc_event(struct hid_sensor_hub_device *hsdev,
 
 /* Capture samples in local storage */
 static int als_capture_sample(struct hid_sensor_hub_device *hsdev,
-				unsigned usage_id,
+				u32 usage_id,
 				size_t raw_len, char *raw_data,
 				void *priv)
 {
@@ -305,7 +305,7 @@ static int als_capture_sample(struct hid_sensor_hub_device *hsdev,
 /* Parse report which is specific to an usage id*/
 static int als_parse_report(struct platform_device *pdev,
 				struct hid_sensor_hub_device *hsdev,
-				unsigned usage_id,
+				u32 usage_id,
 				struct als_state *st)
 {
 	struct iio_chan_spec *channels;

-- 
2.34.1

