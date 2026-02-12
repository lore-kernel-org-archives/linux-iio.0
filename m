Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE78238176
	for <linux-iio@vger.kernel.org>; Thu, 12 Feb 2026 06:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770877870; cv=none; b=sBNEToE+WryDlDdLo+xPejI7Kr7OZy0PaRQ+GXArEd1EUKjtzWnEGSIv1vkTfEEJ54BJ4Oexj86iOwgnPymTY9uhj15IUClBav1fGGgj3CEh1Sjt9LTCux7WlesFiMck5sqzMua2sQ+Df1AMnpVDHwo6lbuk1tg8mKOQxhdThdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770877870; c=relaxed/simple;
	bh=gmRI7aghapLbKpiwYhR02SrobhJ6b11shwU9mxBB3GY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=peoGmSf6LMh6iUXa7qipfzU/PBuzb7Eqmp9vzpwL/Sxin8WDyY9ad80zEFVBGUWjwGQj6z9HDS3qs16PAvGKDOoFqECqtG1M8xxsM6t12p4T8uJ1ETPpLXnULouIOUEjgaEW/rajTgxMQEDQK3BZBHJum3xJrukzTuk5UFqPxlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b2c1TuA6; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b2c1TuA6"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-127337e3870so3397c88.2
        for <linux-iio@vger.kernel.org>; Wed, 11 Feb 2026 22:31:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770877868; x=1771482668; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZFMRcGyf1te/AxGGubeG1NiPmJvyIrPnnKleI39yt2g=;
        b=b2c1TuA6aL+Ya1T0iyfTn6jUTfdgm7aKOYyUFnvDLymeQYcHlYCIdTGAO6fBMEttGL
         lh7Nfn2SkF80lC9C5uk2bqKkq9gjXrstZtcY4KxoVpaIR606MYqGtnc6VQwLNsH8XrNN
         gE+SZecIvAYyw6EnJE1THhIWaEW+SBUdw28Xag/chJ7Wd/fr8wtiVROG/4JL6Lsln5Zv
         Hmy2RuwV2E0L9w2cGDlDWVWcZEQ8D4GYFUzXdCFWjxka+Fja288GLV3yD6fzRxEf3N+1
         KeYWekb491w2ZygRpTeEZvueOpLfplqlga5z45t8LlnYX0ajOUi3zda5I9QSA2l9eek4
         GwCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770877868; x=1771482668;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZFMRcGyf1te/AxGGubeG1NiPmJvyIrPnnKleI39yt2g=;
        b=fV37GcGC4CkijYd8b2AMBxVrF6mcMX0xnGXxojp9AtFYI6ggOmK2H4uvqGQ51Qjuwg
         lgWC38LIGjXHCD9X+Qbg4Exa2HfMbl3a1e3o7RMyEBbKb4bAKnv7ClBdnN9Ea65kSqE9
         oosC2u7bQ9UBbU9PwL6ftHOuKWOjk8XUoGH+roUgpjAT9TZGsAPFFqzHoyJtVZw8rQ9p
         mKs2ptFuvPlPRVtjQIZWZXccvvU5C1BBPHh+KyZMb49wE+GhRLsyjlOg+j/muyaQ8jsg
         EFykB1/Mi5e02QtLBJtXxxRW7VgudyPu4FmmF3pmTkWnEgw65qYe0OmUuRoqR9gxu4D5
         +U5w==
X-Gm-Message-State: AOJu0YyENmZzoLiylR+iia+m1IMqcHiZUmJewqzHfge87Vrq/xBnWKkY
	GgNez4o165UMTQm1BoPBS016suJahuwZN74b3Tzgbppq+fb+nQBVjW5X
X-Gm-Gg: AZuq6aLiq7TBcNiVKOKaV8/TWZR/XqBXcD8HKX1yO8frMDVN6WsknW8RSG0OqpckF6+
	0bklwXUm4DhgMQ5IUxd2Bu1++KXHdGQryAKsshzuL3FHK3spqSahY2Dnj8a/JkaQn9nAYVips5G
	0ZpTTJWKLIJia9XIoVRlMSn70JITscOiEQsINRo4DwXs3CJz0COeM+zS4alfcl3TmMBje9hpTri
	oaEGlWA/dxiQFrc7m6Z+bD7Ev85LIsGxrVX82MK7B7mQATzQZ/rThyrJT9wnXfIpd6I836SvSOj
	fwMqfmAtkiLHhFdL3zy+60pK+s//AXnxUVw1DtPJgXKfawEYJSgD6hASHEzyI+BgN2h6aWp644r
	P13CHLewNubbGUwKoxKkjEzYxmvNyuivfNa0VAHjVatDAzclG3LF1ceQAZmYIkn+fni8Un5o7YS
	OL/LoKH5dv6jIguByt2A+RMnXYYLMc4GcG7jlHNIwW9SPQDwALtw0qzX0=
X-Received: by 2002:a05:7022:6993:b0:11e:3e9:3e89 with SMTP id a92af1059eb24-1272f79a6d3mr419258c88.7.1770877867704;
        Wed, 11 Feb 2026 22:31:07 -0800 (PST)
Received: from [127.0.1.1] ([45.32.86.188])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1272a6f29dasm4313870c88.12.2026.02.11.22.31.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 22:31:07 -0800 (PST)
From: Yasin Lee <yasin.lee.x@gmail.com>
Subject: [PATCH v2 0/4] iio: proximity: hx9023s: firmware property, safety
 fixes
Date: Thu, 12 Feb 2026 14:26:51 +0800
Message-Id: <20260212-upstream-20260219-v2-0-2b28fce5d09e@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKtyjWkC/32NQQ6CMBBFr0JmbU1bESwr72FYjHSASYSSFhsN6
 d2tuHf5XvLf3yCQZwrQFBt4ihzYzRn0oYBuxHkgwTYzaKkrqaURzyWsnnASP6OMwBr7yhq8nNF
 C3i2een7tzVubeeSwOv/eL6L62n+1qIQU+l7auqSTNFZdhwn5cezcBG1K6QMCwXjrsgAAAA==
X-Change-ID: 20260209-upstream-20260219-a7af6d9a85ad
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, yasin.lee.x@outlook.com
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Yasin Lee <yasin.lee.x@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2298; i=yasin.lee.x@gmail.com;
 h=from:subject:message-id; bh=gmRI7aghapLbKpiwYhR02SrobhJ6b11shwU9mxBB3GY=;
 b=owGbwMvMwCEYyfeRr6Zs90zG02pJDJm9xXPUF85IDVN3ztpe9flrlplTxqkn0VN3WHr0qW089
 tHx/a9LHaUsDIIcDLJiiixnXr9hzVd9uCf4t2sGzBxWJpAhDFycAjCRGHWG//7317rzemRLOgSe
 uOx/T5h92bvWZ7f4HJJ9IzxVPy9b6crwT2FX3p0e9UNvz/H8ml30Y1PNXYP0TI8I6TkXTm7PCt5
 wxAYA
X-Developer-Key: i=yasin.lee.x@gmail.com; a=openpgp;
 fpr=CCEBEC056F25E1BC53FB4568590EF10E7C76BB99

Hi,

This series contains a set of small fixes and improvements for the hx9023s
proximity sensor driver.

The changes include:

- Fixing a potential out-of-bounds access when copying firmware data.
- Avoiding a division-by-zero case when the sampling frequency is unspecified.
- Allowing the firmware file name to be specified via firmware-name property,
  along with the corresponding DT binding update.

All changes are independent but related to robustness and platform support,
and are grouped together for easier review.

Tested on a DT-based platform with firmware loading enabled.

Thanks for your time and review.

Best regards,
Yasin Lee

Signed-off-by: Yasin Lee <yasin.lee.x@gmail.com>
---
Changes in v2:
- Patch 1: Added Fixes tag
- Patch 2: 
    - Added Fixes tag
    - Changed conditional logic to positive style (val || val2) as suggested
- Patch 3 (dt-bindings): 
    - Removed redundant description.
    - This patch now comes before driver implementation (documentation first)
- Patch 4 (driver): 
    - Fixed variable declaration order (reverse xmas tree)
    - Split declaration and assignment for fw_name
    - Removed unnecessary error checking for device_property_read_string()
    - Simplified to: fw_name = "hx9023s.bin"; device_property_read_string(...);
- Patch 5: Temporarily dropped (ACPI support)
    - Will resubmit separately once TYHX vendor ID is officially registered with UEFI Forum
    - Need to provide verified DSDT evidence
- Link to v1: https://lore.kernel.org/r/20260209-upstream-20260219-v1-0-2b4d74e309d1@gmail.com

---
Yasin Lee (4):
      iio: proximity: hx9023s: fix out-of-bounds access when copying firmware
      iio: proximity: hx9023s: Protect against division by zero in set_samp_freq
      dt-bindings: iio: proximity: hx9023s: support firmware-name property
      iio: proximity: hx9023s: support firmware-name property

 .../devicetree/bindings/iio/proximity/tyhx,hx9023s.yaml    |  4 ++++
 drivers/iio/proximity/hx9023s.c                            | 14 ++++++++++----
 2 files changed, 14 insertions(+), 4 deletions(-)
---
base-commit: c8bfb63c902678228a0a265e22a5f55404988a43
change-id: 20260209-upstream-20260219-a7af6d9a85ad

Best regards,
-- 
Yasin Lee <yasin.lee.x@gmail.com>

