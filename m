Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF833859D5
	for <linux-iio@vger.kernel.org>; Fri, 27 Feb 2026 19:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772219318; cv=none; b=du+dh/rJVO5G7+9g6SIekevKP/Gln5tf6aqfdlSFYhy81wo7ShBXetoqFv4vJV9lYlsoj9QW7GRoLgKeD/a9zM7evOjVr8+RL3h8wmSaXYKnJnAN5rk3uQ4k3I+qUBVcLdNzA09qXFmit0WsIRQKJx6TR3VWxXsGThucAQqhkKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772219318; c=relaxed/simple;
	bh=589BKfYJnX0xBq2QFIE8KktMFxmjY0H22bxg8JH0DTQ=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=t5cAQNmlCWSg6rApxMAzX00LxuDBOHum+imL5jXTLwOZ1+B2V/uT2MNqWGA+Y9BvegVRYI51BUMpmJeOkyj2GbvtJW9d1BHK9eCpDKwVOPQOM8qUcslSQIG7lxfOw7G37ds2sFb8Wk/S70fQcWAT56tDmvZjRn9Jjx9tNRUv+zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nd1swH3B; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nd1swH3B"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-506a297c14bso22329811cf.2
        for <linux-iio@vger.kernel.org>; Fri, 27 Feb 2026 11:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772219316; x=1772824116; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3pUhkYNCOHcJIt/TwrF1xrDtMqe67JCJ7QQat4SlfqU=;
        b=nd1swH3BdQhLW1/u15z1HfZH/rqada5tGGq7Gj1cgztxdgbWUsHy/6tDKxuKCn6VD/
         wqUuFaMLdgTw0KarCJ9I6H4BayjaXXnbjbiOHpg6o83V35dxqFuFRt7jrOOTOzlNotDK
         oXyTvVGN+UjOXkCFmn3oQhI+8RLYITeBrR9cq4ISkPjGEodkE4M8SZb4A1gEZSxKdavg
         sVUlwEfi2z3LFb0kg/ejS06CV2hqxnNQVbLJ6o3rrodrBBkETZ0MYlZkrq9sRzylZm4P
         77Y//ueDVcoj87uGf6kbDQ3AoJdW/9ir5S/4PF1t3LAZHR/IZy2WdRgYfBw6RoMLmds9
         VRGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772219316; x=1772824116;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3pUhkYNCOHcJIt/TwrF1xrDtMqe67JCJ7QQat4SlfqU=;
        b=pniqYl/47Pplig/ChpuyBjLlGeK8etqIqyuKtESuZQoeRM0gmKB21D+3LPIIIAQIR0
         3L1BclxjRXnXzlOlxObNOJVrE+9CNyqTosXg2d6kA9hpvTjhTN8w5lBAHfoDaK2BdkAO
         qcnPgmuSpvuQivhbZShSxYf7wVfmEvyK6lXIqrrXg5zCHrKFPKx+IL84Dg5K4LCbUSg5
         eBsR2nNCrrW4B3VXibcek5wxGaE6K6wEqi/CFXb5k4NfW6kq0rTKRKgaWisFghqKx7L6
         qXS2IWfzX0fko2+KwxumvPFUvh34x/Alsl+XKCAPlMvK6cCTZR3eX4lZPojLgCbO+DLY
         5s4w==
X-Forwarded-Encrypted: i=1; AJvYcCUb4pntEfQlaenGXi2+JmEtwxQv0S+3RxG3RePHYjTnjI9otWWczrFbmdl2DW1w8CXVBtdqi6Y2+4U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHWZTTQZKnXzwjiw4CgPiUBWfwx/KT3OxCJflnYcIgd1yt+tGp
	mn8b6vLJE636oHW8pbaD+6lgN1JskRc9IQdwpgOZJb9mEauwOCBSl3jO
X-Gm-Gg: ATEYQzzv+7441CehRox9McDD6IKKV0JMVPMQWmfvgBEs2WDvSSBrYV36O2KJ/qJQ0nE
	SLiGNzEu27ptqCKR4dvsnfmi1f2NcPItfdN8jh9euEyTXqhW7/LFnXIQzvJmUwuwgMV/3aXtZYg
	Vvbmcka5pCt6VTo4fA8oLn4bR3ZyZdL0NBnMwWtptcrBSnRlFNP16zCbmED15B5gjShSmZUqqWV
	YkD3iQZPX20JwwkQCEYe7FmVhv7UBRRubWm5HZ32lf+Y8jWAo91StVrLEvFl4egQswrvibgnLTU
	0v7PpjEzXLNkwVWib3id311W/XjFF9vJd6RlZepVzdKrMZjGw2rsxXF7UHCxikRWXl8ZCsitPTR
	FkUpaPuCfgm879KiTlEgMb5OlReD62EQ+u6OcOZh6sFnmpazm0+EoAVTPwlxdys+d79cokO4Wn+
	AFpTT7dbiSpeqzieE1hX271H/SL9JVdl/tO7pzSpIUisje3vKJY/1nDGOzHDSqGcMwkEvIznPht
	8EX9aTlRnIse8LcZtUFiSxNYFi2cz6G8KfwQ3HFlxWPPJnSm/SBnePzBbbL+cxXEu+Wr+2oOTbi
	ttbW0bsZQUmptFxBaJvH
X-Received: by 2002:ac8:7e85:0:b0:502:9e4c:266b with SMTP id d75a77b69052e-50752999d75mr47339771cf.42.1772219315950;
        Fri, 27 Feb 2026 11:08:35 -0800 (PST)
Received: from ammar-VM2 (d66-222-145-193.abhsia.telus.net. [66.222.145.193])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50744acf0desm49676961cf.23.2026.02.27.11.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 11:08:35 -0800 (PST)
Date: Fri, 27 Feb 2026 14:08:33 -0500
From: Ammar Mustafa <ammarmustafa34@gmail.com>
To: Alisa-Dariana Roman <alisa.roman@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>, linux-iio@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] Docs: iio: ad7191 Correct clock configuration
Message-ID: <aaHrsTS9iG-PEfue@ammar-VM2>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Correct the ad7191 documentation to match the datasheet:
- Fix inverted CLKSEL pin logic: device uses external clock when pin is
  inactive, and internal CMOS/crystal when high.
- Correct CMOS-compatible clock pin from MCLK2 to MCLK1.

Signed-off-by: Ammar Mustafa <ammarmustafa34@gmail.com>
---
Changes since v1:
- Instead of using "tied high" or "tied low", change to active or inactive
to remove confusion.
- Undo the swap of entries from previous patch.

 Documentation/iio/ad7191.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/iio/ad7191.rst b/Documentation/iio/ad7191.rst
index 977d4fea14b0..fd6a23ad44fd 100644
--- a/Documentation/iio/ad7191.rst
+++ b/Documentation/iio/ad7191.rst
@@ -63,11 +63,11 @@ Clock Configuration
 
 The AD7191 supports both internal and external clock sources:
 
-- When CLKSEL pin is tied LOW: Uses internal 4.92MHz clock (no clock property
+- When CLKSEL pin is ACTIVE: Uses internal 4.92MHz clock (no clock property
   needed)
-- When CLKSEL pin is tied HIGH: Requires external clock source
+- When CLKSEL pin is INACTIVE: Requires external clock source
   - Can be a crystal between MCLK1 and MCLK2 pins
-  - Or a CMOS-compatible clock driving MCLK2 pin
+  - Or a CMOS-compatible clock driving MCLK1 pin and MCLK2 left unconnected
   - Must specify the "clocks" property in device tree when using external clock
 
 SPI Interface Requirements
-- 
2.43.0

