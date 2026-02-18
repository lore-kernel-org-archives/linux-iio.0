Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01AE2309EE9
	for <linux-iio@vger.kernel.org>; Wed, 18 Feb 2026 20:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771447971; cv=none; b=qlqVwQHebFjwwisj2NfHhaZ7HICzrsRW20tNdw+8/NulxKApS8uqJ77FAzju5iW5wlYgm/8cFbIlyipcmXJzK2hQQBkH+5Ea5xWIlC7AWCl8w2veoR5fFyssublVEatVsqUOF6HZKvspHIGBNqygqqo5eWF7wRDzXvq6NB2r3h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771447971; c=relaxed/simple;
	bh=gVUXNAx5ipEs7JptNelgk7joR/9IsRhTWKeYYuuu/B0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=gcxLiRmBrlvA6bFdgY3WoGyeKeeISRKy+X1GHUav4E1BMR2e4vPozQPXGSrGnZGSVu2tW5Q6FfifoRwEYNdmJ4Y8WYtPCbTZcCXQxWLPvPXD922ZhZ0X3Rxtx+BJsFKaYvKRVzBCx+TzZkmO14nLV31nRyVoe37XXKuI65RxzoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ku4N/NdQ; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ku4N/NdQ"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1275750cfc7so331057c88.0
        for <linux-iio@vger.kernel.org>; Wed, 18 Feb 2026 12:52:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771447968; x=1772052768; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d/0FpU8lXYfK4+auQs6w7slKU7OvSIPS213kGUpKbqQ=;
        b=Ku4N/NdQyCKydwhBSzVw33EAt3oL2BbBZNh2xTgT7H8Ag7hQJ8O7OFrsECzPf1Qw8z
         0v/EaH9yw6N2xPmy6z+u8H6h+KlOkyO9K9JHmYhnH9Q6SiIVIjRhahNx4mLxZmQICued
         Pn+uzBtE4BrlvH7+/7tOaPtoLxEoqQrGD8jlTzafbimK5DGvftZt/v6hrPssFAkg0edQ
         oIEs0iIoD7AwTt3wyvqKbyeX+nMFELwzeC50OlIKbfMw3fBU3RTbhUhC4LfTegLDzSmN
         lFnY/vqLrR+8VOZLawwrRXWM8E2hGVIz6QUghvY+nc39JMGoE0zr8pku7BfIeWFOFqgy
         CvCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771447968; x=1772052768;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d/0FpU8lXYfK4+auQs6w7slKU7OvSIPS213kGUpKbqQ=;
        b=ERX4BR7h7a8gJRw2LXQ5KOREKI/WTjOqt+5IPU4PICL8l3EZzMfHQAawI0H4YDES1s
         jFRFsdDrSQhnbbknpSNLB4LoWhZSNNELMbk9zxrqg6zAzUmqlaWRbmp5GWBiQnrw/0vj
         4yCTwI0jmbLm9O40+n0oh5LJ6iHQppPDuw/flAjiDS11YnfJ9RGfU7i/mL+gNg/He8qw
         C+jS9aNDiMS85/1KqdAPyNxzJs4pwWR8da7+QYmt//4JAJ/W6urtJfwT46hp2bsXG1iS
         wEHEU+NfdHH3JwSCCpZtxIacSnbEn4SL9jJqxi6Hbkn+pPpV8BXOhKwjJqrX/d2JbXgy
         ibig==
X-Forwarded-Encrypted: i=1; AJvYcCU+fUqn7QspVKMsFk2/8ApXJJLmEsWsQ105a0ekeUHBHvXLEZxlHsZxdqHTDH4mhPCDLzHqwrTqjeY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFdiuOwFwEPSRbeJcTUe8bhEi2jL3eUk9YAg4I1pZFCrFR6AU/
	8avLtC1y3LlYhSSYQaBddvALt7bA8H3ox5VTUxf4pvdhffOQ4gbllJwg
X-Gm-Gg: AZuq6aJQ8e27cHh+GVBa7cmPG9Z1cK5TsZaSDz7FJ03c90wLNDck4z0wrelqyJ0TqTV
	mMD9lPHd1l0nTj3hQkI0tSSaQ6ewAt7rz+FjIG98ZgibzslUjmMsb0fn5QcMdYYpU6H30uyl4QA
	HEHETRMEMJsky18h4KuWr3khVhjXbwRHxki+Fl9Ph0ilVC6hyOllZYoOUxD9Zmzyw1Zk5GBCoed
	VdYY6adAzi/fuHrWXmMUVK+o2883TBqSK0oNDA81PcAz8I4uULK4biIU9Nny/n67FMmQ9aeh12f
	4rZYKOPTd+vmUFAjWdqpMKV9xryif6AlcllKn2mHA2YCxndn6VGNGkOHtgkpFH3HGapvKQ+DhAw
	TMtFq0qOkC/0IKbK+9T9aPQyto9vLMkpjZ8yG4Swj/7WGWMz35qXcn9Jd5MjtNeO0y6UrhmTduY
	N1dvTmphIjo2blIqojy8j+vS1zi5t8nNMWiYGZKLKqtjnTpvcnI/Lhz3iFj8a+LTh/
X-Received: by 2002:a05:7022:2212:b0:11b:bf3f:5240 with SMTP id a92af1059eb24-12759a103e5mr1793279c88.9.1771447968052;
        Wed, 18 Feb 2026 12:52:48 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:265b:f5ad:9e03:677e])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12742cada1csm19332477c88.9.2026.02.18.12.52.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 12:52:47 -0800 (PST)
Date: Wed, 18 Feb 2026 12:52:44 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, 
	Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: [PATCH] iio: adc: ti-ads7950: normalize return value of gpio_get
Message-ID: <aZYmemDCcVzPB1RM@google.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The GPIO get callback is expected to return 0 or 1 (or a negative error
code). Ensure that the value returned by ti_ads7950_get() for output
pins is normalized to the [0, 1] range.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/iio/adc/ti-ads7950.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ti-ads7950.c b/drivers/iio/adc/ti-ads7950.c
index bbe1ce577789..0c4db18ec4d7 100644
--- a/drivers/iio/adc/ti-ads7950.c
+++ b/drivers/iio/adc/ti-ads7950.c
@@ -433,7 +433,7 @@ static int ti_ads7950_get(struct gpio_chip *chip, unsigned int offset)
 
 	/* If set as output, return the output */
 	if (st->gpio_cmd_settings_bitmask & BIT(offset)) {
-		ret = st->cmd_settings_bitmask & BIT(offset);
+		ret = !!(st->cmd_settings_bitmask & BIT(offset));
 		goto out;
 	}
 
-- 
2.53.0.335.g19a08e0c02-goog


-- 
Dmitry
