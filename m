Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5C84A33
	for <linux-iio@vger.kernel.org>; Tue, 26 Aug 2025 00:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756167014; cv=none; b=QWABPdH3tnFvEfVHh92X7M9WZN/wZ6uBcmPI8Ikw4ohFPn6IgKhzx7ngp8bJVOKgAKQgS7yl7OOWA1hgWiP8Fw3lzRbYs6cRsQ2Gx00yzaurvzIosYe6w60MjgJ+xKjQVauT3isHFwf9qlf1z5EorfKPz2xAywSFiIZps5anYEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756167014; c=relaxed/simple;
	bh=+MzvFeNJiDEBQ1mrqEG/peSy4HJ1qlP2TRscSwtRZmA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LpMJuXjnwuKtcHWN5J1FaUMvsl4BYhHFLnI/JPK0jiw6ISfLMNAG+0UDD6Epr2OzRafxSrzlhS4/hpL4F38sxCujJ35KB3MQLeZel01yz7YYoq4SXJktrRqG+hWo40DVwHo/nXPTK8EMUqrT5TlTRjW/gmv4/mHIw2LBb8hk9MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=linux.dev; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ben Collins <bcollins@kernel.org>
Date: Mon, 25 Aug 2025 20:10:04 -0400
Subject: [PATCH v7 2/5] ABI: sysfs-bus-iio: Disambiguate usage for
 filter_type "none"
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250825-mcp9600-iir-v7-2-2ba676a52589@kernel.org>
References: <20250825-mcp9600-iir-v7-0-2ba676a52589@kernel.org>
In-Reply-To: <20250825-mcp9600-iir-v7-0-2ba676a52589@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Antoniu Miclaus <antoniu.miclaus@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ben Collins <bcollins@kernel.org>
X-Migadu-Flow: FLOW_OUT

When a filter_type is "none", there really is no useful information that
can be presented from sampling and frequency attributes.

This is especially true when the driver supports more than one
filter_type, since the information would be ambiguous.

Suggest returning IIO_VAL_EMPTY for this case.

Signed-off-by: Ben Collins <bcollins@kernel.org>
---
 Documentation/ABI/testing/sysfs-bus-iio | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 7e31b8cd49b32ea5b58bd99afc2e8105314d7a39..df42a4040530ee96096b998bebc8a08b4fb2d78f 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -2276,7 +2276,11 @@ Description:
 		Reading returns a list with the possible filter modes. Options
 		for the attribute:
 
-		* "none" - Filter is disabled/bypassed.
+		* "none" - Filter is disabled/bypassed. When set in the
+		  filter_type attribute, a driver should return IIO_VAL_EMPTY
+		  when reading sampling and frequency related attributes of
+		  this filter, and return -EINVAL when trying to write these
+		  attributes.
 		* "sinc1" - The digital sinc1 filter. Fast 1st
 		  conversion time. Poor noise performance.
 		* "sinc3" - The digital sinc3 filter. Moderate 1st

-- 
2.39.5

