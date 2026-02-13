Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA0936215B
	for <linux-iio@vger.kernel.org>; Fri, 13 Feb 2026 15:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770996120; cv=none; b=prneEjjJTnI2y11TI3Cr5DvQXvqq4zlWg3EMZwdXa+KqYxOzix+4oTRBcg4w6Fo9gGwGMqcDO9+7h0VNuwxZhlJ1kpYkTN/IZvRR5gtY1lrJkRm8ypLKZnZglSgfguz23dVbEbce0FK5QyLvS/Y+lHgSz6A7VMnJds2+IxvsUjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770996120; c=relaxed/simple;
	bh=uydvb3LqyX9bVJlykw6NIMEUAdvxhC/xs5cOSq50KTk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Z9LEpiI38RprUd7rMryIOD0/VAGA861bzSyfZDIMfMZ69upIPTNkqV3zZy9i+s56h/exWj8TpjDpkC0xkU3t1vvTMEraSSLDjcOFWRSg+AcN7/h//sMNXQjP71nKPAkawAz2c+rS3aF9y5MBTRtWwWUnd799aiDRXp/wnDAhutk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R6tuS2og; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R6tuS2og"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-2ba6737fafbso59879eec.3
        for <linux-iio@vger.kernel.org>; Fri, 13 Feb 2026 07:21:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770996118; x=1771600918; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FtiEbL14aQUzb7T6n5oR3XhpTAebmhHLOd3OCZt0J6g=;
        b=R6tuS2ogYnlRH6I8UHOEKas0TU1hUtEXZwQ7hXbPGYUmHb3mHZ2+Mfmg38FmYxAUgj
         SumPCJlceAMX/ymiARxcO/QXBypKEoBw+1eK/2ddju+gKpXW5dVkQADnuR3NNnLF8Iqe
         hRbwd6vHm+fb6FlnmnPexM7il+eR8lC1yWNmT2t818tzsyJPV5CI7xkUhAUiVY+tOjJE
         8z1EcmWh4e+8sT94j9TKDQ+5K+6AFStjJwT2/kc+T9G0gHdLIBj8JJXuv48x57e/UJNr
         35WSc95ezlr1Fqc84EEtGIfHcaSm8kTO04WuNoF7LQ18W8qdGfc6LY5oSZ3jGlQZgInu
         U0bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770996118; x=1771600918;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FtiEbL14aQUzb7T6n5oR3XhpTAebmhHLOd3OCZt0J6g=;
        b=Mg1IViiJGwAzikDUsy6fbg1d+Q7Yozk4nceBy0EeYaBuAUV7u9m9l52qTON1ty4Hap
         zmkKa1e9YcntrKHQr+PYG8wgVyqwUOm5eVd324AyH554s0DYudIoLLhQE010FtBXlDnY
         JYLRNJhuPYjxHv9u09tsTwthb0xIN/Y5oCw6AlRFYJzGmRA5X/1Br9dH+7DC0I0v2fzc
         KZEbFz7lAwIg/TzOdm/DeCxTnu0j3wYaHd+Wf+Azk+n8igs8F7SncJNnQ8GYhzrbl7Ui
         3nhy83Hr3NNX18sDM9KvRNEA4CNEQllt6/iaJugzxzXvbVeGYh0Vf0mNFPa9aclNf58S
         rPtw==
X-Gm-Message-State: AOJu0YwtJ7FiHMPdoXo74d3vFmnnwyHbPT3+WdZVaNcxewWxu2WhZFub
	xtQ7yWDcvd8iN/yZbNzsxGXq/x06IYI4dorYv5MH0m4iundj4nqDQX6q
X-Gm-Gg: AZuq6aKh1ja49WJ86ob+bVcx2+FK2uY0yzBIy5/pM23Q/7Zp4iErgEBg5RYWMD7Oi0a
	M8h7WwaPyW3Jhc35DPGnCGAcDoAn/eVQhBbOpc7HpFUUcGfh7dsUqMGu188gU2dpv0Hqc05AFGp
	jXuRuoy42h2k++D30lSmV5vHlsA0deOGguKosYQp1UUgfbOjbPSu2YS7/hC7DG9xOK/4bsiWLEy
	I0jGH9qGZJpqpLE/7OYIaszdUC+MHRMmowR8ZBCPnkXD1GHN17Ex/V6YaBSUvG5M6um+mV3ytBQ
	Dhmn6lm50gQ1T2v80b1PeC5+vDSi1PvFSc3Y5gJBcURT1X9Qyo8rPWKVXNyqAR9LXh6Sk5Hh3dm
	v/InivJ2cmO4pZrDZYtZ1OaW6YW+3HK512+5HNMg8lV7AHx2D/NoWPJ6u5m8Q6edYE0RlN/4+C/
	rklBnVFEZsYGUGV7W0iX14Sk+MHmvMs144Wpl5LCblBvXmA1anPyAuQLA=
X-Received: by 2002:a05:7300:324c:b0:2ba:6f02:2939 with SMTP id 5a478bee46e88-2baba0131d1mr569132eec.1.1770996118050;
        Fri, 13 Feb 2026 07:21:58 -0800 (PST)
Received: from [127.0.1.1] ([45.32.86.188])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ba9dcd01d1sm6755006eec.17.2026.02.13.07.21.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 07:21:57 -0800 (PST)
From: Yasin Lee <yasin.lee.x@gmail.com>
Subject: [PATCH v3 0/4] iio: proximity: hx9023s: firmware property, safety
 fixes
Date: Fri, 13 Feb 2026 23:14:42 +0800
Message-Id: <20260213-upstream-20260219-v3-0-df9371d29f5c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOI/j2kC/33Nuw7CMAyF4VdBmQlK3GuYeA/EYBq3tUQvSkoEq
 vrupGXpgBj/I/nzLDw5Ji/Oh1k4Cux56GMkx4OoWuwbkmxjC1CQK1BGPkc/OcJOfhdtJBZY59Z
 gmaEV8W50VPNrM6+32C37aXDv7UXQ6/pPC1oqCffUFiklylh9aTrkx6kaOrFqAXaChl8CbAKUd
 UWZVYb2wrIsH9YcFeL0AAAA
X-Change-ID: 20260209-upstream-20260219-a7af6d9a85ad
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, yasin.lee.x@outlook.com
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Yasin Lee <yasin.lee.x@gmail.com>, 
 Andy Shevchenko <andriy.shevchenko@intel.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2699; i=yasin.lee.x@gmail.com;
 h=from:subject:message-id; bh=uydvb3LqyX9bVJlykw6NIMEUAdvxhC/xs5cOSq50KTk=;
 b=owGbwMvMwCEYyfeRr6Zs90zG02pJDJn9jq2cPcyWZS7ipybMNvE0l/GIOKcnUqW24e73tGyn0
 6tl7lzqKGVhEORgkBVTZDnz+g1rvurDPcG/XTNg5rAygQxh4OIUgIl8m8DwP6P4rMGXmexssa7e
 JqdyJux9nyDVMnfHp2V5lR4uhf35+owMt3y70g1SDvMENk8/Jsaz82R2N3/OV8b+RVMvvxRZ823
 vHgA=
X-Developer-Key: i=yasin.lee.x@gmail.com; a=openpgp;
 fpr=CCEBEC056F25E1BC53FB4568590EF10E7C76BB99

Hi,

This series contains a set of small fixes and improvements for the hx9023s
proximity sensor driver.

The changes include:

- Fixing assignment order for __counted_by.
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
Changes in v3:
- Patch 1: Refined the commit message to accurately describe the __counted_by requirement.
- Patch 2: Updated the zero-check logic to if (!val && !val2) as suggested by Andy.
- Patch 3: Enhanced the commit message to explain the necessity of the firmware-name property.
- Patch 4: Collected Andy's Reviewed-by tag.
- Link to v2: https://lore.kernel.org/r/20260212-upstream-20260219-v2-0-2b28fce5d09e@gmail.com

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
      iio: proximity: hx9023s: fix assignment order for __counted_by
      iio: proximity: hx9023s: Protect against division by zero in set_samp_freq
      dt-bindings: iio: proximity: hx9023s: support firmware-name property
      iio: proximity: hx9023s: support firmware-name property

 .../devicetree/bindings/iio/proximity/tyhx,hx9023s.yaml       |  4 ++++
 drivers/iio/proximity/hx9023s.c                               | 11 ++++++++---
 2 files changed, 12 insertions(+), 3 deletions(-)
---
base-commit: c8bfb63c902678228a0a265e22a5f55404988a43
change-id: 20260209-upstream-20260219-a7af6d9a85ad

Best regards,
-- 
Yasin Lee <yasin.lee.x@gmail.com>

