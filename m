Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3C438C41B
	for <linux-iio@vger.kernel.org>; Mon, 11 May 2026 10:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778494497; cv=none; b=Q7sLmC+iCn7a2TS6x2gJcfqgJsTo/MElq7vRKb5ek4DBqxZ97C8xfoX1Gq3RLtClu3ZUu0Y7QiuvOLOAU16REPyAml+L8IsD43YkSBCMk5jLs7P/m+q6JzISWGehzzo1mYdhI4mIeXrILfbeU+rplz23pKinkGv9uUWWmbD8dWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778494497; c=relaxed/simple;
	bh=1oTqfE/mrptSH/cjL+2i1lXLO9tv+eW10c9GPhckjbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BqTNqZQaDPCkZNtCHvxG5MdSUKmn7OaC5SRINxWRa0ECivKyTXsNl1IdTmiRZVPSKYoIm/884HkQYpV9O6a+6FcEBMY6kVaRJrFhReE6Wp7KEzZQbrMfKg0r1BucxmS+o9KCzNRPULoYBe6+2jA8ZpJalpQdzkc7q+q6kN+xOiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YU9AeCUe; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YU9AeCUe"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-67e2498f3a7so6805069a12.2
        for <linux-iio@vger.kernel.org>; Mon, 11 May 2026 03:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778494494; x=1779099294; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GUhC9JwgaXAF7yoYDnZMF+zWAmJghCqIDAyKQzYGhuU=;
        b=YU9AeCUeIJGeq9N/cbRmhMwEV3jcu0g10wp/jjn2alZ1TIZzH6+pulPMAKj2IQe40u
         yJdInvAuXzid9n/PETfwPHTcAEVtElNfhRtPbr8i4qSR1fAqnIVCQbnu/rUaM/Z7Mkej
         pn9QFGGhIEcK5NNZ4CUH9og2sseJj6qDOpbq/RelImdfbIY9t2IP9L9xOhAUDd69C0wc
         z1wOO1yHTYLxmUHaEVYy2dIkis0j4pQB49TedDMbMJXG//pdEZ4z/ozRI5+frlx4Sn99
         K+F8aQ9JmUA4EuRaxaCQDfuLfyho/N5iAFs/8kShuPv4FdJOfVkGMiZ4V05/S1rl8vB5
         JALQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778494494; x=1779099294;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GUhC9JwgaXAF7yoYDnZMF+zWAmJghCqIDAyKQzYGhuU=;
        b=XEVCq4ThE1W9PrnlOCLps0D45dBlxFgKAqS4uqxIWeemM6FCrjhe9DWKZBkFn3UwL2
         7syWjKgWYjNUSI68Y6O/uVYdAtLHSfhXdiSPLXe7yl0YtnMA+bpIk3SYhCEvh9rdwLPS
         ZleP7SwcAqa7z6XLS5hXE/qh/eNM785PP9H4U1UkSJH53BYywgb0swzur6sTtS9mjLSz
         9lDthjgjWiR6fUGp/U/5g5OS5zB6d9IIK6AXfpvjyj9x8TRSFYZ4pLWvHRnXPdhnpqXn
         Z2+PTkgLGpnXF8P0cDtlTNrkj6Psaq4X3xLcLHywtGP/vk0EesLzSIN+LJlKfDRtXu2w
         Ve9w==
X-Gm-Message-State: AOJu0Yzr0iSJjEIoMsSgLcXS88w9nvKuHdkme/YmdOJiBbcB7sq6j+Il
	i8jO93glGM95FC+Yg+k+mAfRZ1wPefIwmQBD5KMT8beNf+uAhuhkfM5HP8+v7Zh4
X-Gm-Gg: Acq92OG394JOm3TRdf/vhI7IDJXFBVxEmf3MP2U6topkLbgXX7h+nhtZ4tiPqIgM2xl
	sVV/Ikjh0gc6Azz2UiDCqIR2g8E1UevOhOLlEWy90u9UATzjkfN+ci7+a0WXJRlZGgeiqpRX0Or
	c3Bp6YUhS9YOEazOzwebHty5YxPNWJbGutryyMqY5gqj7ORbgWBqb7OBR1gm3NS61PIhro2yM59
	fC71slE5CD6UHpxw4kf2fpynLY32jNxhS/5pllOiiweBV3NExsQDt/Epe+mcvcbI7lyPw5Nk0KQ
	eLNR/KVL2jcijjRwhCG9ZSX/Gj1HR/NzBrymuKp4KybsRhG4wuhf76Loo32Q9YlQxNUHgZ7JOJG
	SFqxBkVZKVE9eeIIyKMBxrF3WFT+vn8tXdoo1AX+eae6XHwUYRlOEB2c/ZWtv/KBQF14CzLG0At
	dwT/qVEtrSdLTMBOK+rwEQvLfgD7Q=
X-Received: by 2002:a05:6402:1f03:b0:67c:1ed6:2793 with SMTP id 4fb4d7f45d1cf-67f717e2fcfmr4112812a12.22.1778494493900;
        Mon, 11 May 2026 03:14:53 -0700 (PDT)
Received: from gmail.com ([212.75.105.246])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-67ef0b3ba35sm3565036a12.2.2026.05.11.03.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 03:14:53 -0700 (PDT)
Date: Mon, 11 May 2026 12:14:52 +0200
From: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>
Subject: [RFC 4/4] MAINTAINERS: add myself as APDS9999 maintainer
Message-ID: <dced0d8107c8f046a80128ec0fba85b764ef1848.1778491503.git.azpijr@gmail.com>
X-Mailer: git-send-email 2.54.0
References: <cover.1778491503.git.azpijr@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1778491503.git.azpijr@gmail.com>

Add maintainer entry for the APDS9999 driver.

Signed-off-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1aa9c989973f..cdb703f37f06 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4302,6 +4302,13 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/iio/light/avago,apds9300.yaml
 F:	drivers/iio/light/apds9306.c
 
+BROADCOM APDS9999 AMBIENT LIGHT SENSOR DRIVER
+M:	Jose A. Perez de Azpillaga <azpijr@gmail.com>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/light/brcm,apds9999.yaml
+F:	drivers/iio/light/apds9999.c
+
 AVIA HX711 ANALOG DIGITAL CONVERTER IIO DRIVER
 M:	Andreas Klinger <ak@it-klinger.de>
 L:	linux-iio@vger.kernel.org
