Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7FF73C9438
	for <linux-iio@vger.kernel.org>; Mon, 11 May 2026 10:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778494487; cv=none; b=nkqE3qOdVp6bZi2HFhnEgc8zjfGk+Y3PX24ePbMB52rVAuV9hQFtMxFveNlLK8KaeZRyh6eeWJoYVZ488OFT3CMAc8WyaGOxyM1jqnVv5rzg1SOqe2AWnzfOxrcrJXaAhf5/g7UsK3EH8QUpLdneLbMJJmNLxZm0eafzdoUTzow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778494487; c=relaxed/simple;
	bh=X6QBcyVq1LZOJ8ISZQOiIabAew+uR9lYTdWcV1szgH8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=NE6LsGnxFjWqkwANi2sLSKPUV275GlI+wKfD7SQ0gCMvNGtn8+k3Dmy9Y4y254wS68UUEKwpdcWgDrEWl/sHk0/ebYoCK67kI7uZStLYprdPrpqcwVO8f3ndtesgM48gKXDOQBp+oyVi1duB3rR8NyBreVqF7NLut9z0WIVXchw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QHkjTYBu; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QHkjTYBu"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-67c2b4809baso8136393a12.3
        for <linux-iio@vger.kernel.org>; Mon, 11 May 2026 03:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778494484; x=1779099284; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PPUmEYkZ46ih71VUOgzRg1nrxnK4DBaB12Hwwp0dJww=;
        b=QHkjTYBuyPa5nLhSKau0UQkR0DTuBBGwKjTRdY2ZAc8BloS7R9cowK1VAM5lheXxxG
         rqurx5EZa3pU06ai42x56EDLXYmiouKiBxxYTHtNl6z0sEgZOiWKlMlPMwWpDbHyAF6U
         Qf7OmBvzXCDGBYc8XEE8d1H1DjAeW2Gn/UXf96MHgxoN6JAHs187nDfAUlsSbuY+6CU1
         fA7/ujbnmoBuWfvtNgSKIAldC3GXmmdWX+2broDef2Ud9l651HlehQP8cfUR1ZsplhXp
         ISiYZPgv4HYBq+hktttZsDGllpZyK4RCN/nEFU0K0fcpPRW/TcBQ63CEdbhLjBInQkaL
         JkVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778494484; x=1779099284;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PPUmEYkZ46ih71VUOgzRg1nrxnK4DBaB12Hwwp0dJww=;
        b=IdF50S2CVc/OAMhnYEfYqutkb860Vhg91+UmXA9EtunlAgJRPDLGv8vdaz1JGQUQQU
         55CaxLMIaE1/gwA3nmW+MIb3TfVghpr6Vs3vaNuaBcryR430BBv9GtPi66VOv3EG9tXY
         SJrnIN5sfpoN6M2uPhF3dNPPvIE/vC1c4cijir9fh4xBxVO/avsvLKY9JG7bbi077KjB
         Fkm7q+TpqXRnqosOT/dkG68iD5wQ+HI1tpky3aCPahIPqFn4a9Qx0E8VFJRvp0crDKPs
         +XNnj/rPrUfFYTbVoFjKGCJmR0xEJCx3WEImdIweHut+AlZlBnt8BVyJ+sgZDU5Pkcee
         oFRw==
X-Gm-Message-State: AOJu0YybImQ+x65iFLomKUddKc4IPjP8y2SDf3UT/RSyB81BpyA8Jfpn
	THaJ7KdWCgDTD5ekYRxyTCjUI2dHuDNsOQaYdJ/7/Xh1jXvzKoBGe1ANpwlCO/XN
X-Gm-Gg: Acq92OEps+4RyHY5RYFtvLI5GoFxm2uLqw4ml9DIMfAzzxu7kdofVuQIqv6tr3XyKhD
	6E4tDdV6tXK+7s3MIV73mMmR45cvM3w7GtLOSCxzKAPBuWoBPQLGCfjpl4iCmoQNlb0UqEDtZya
	sH4RHTja+MsBb84TY56C6gElqu0zM32ypCwdsfqQNPCcV391QM0puLeQ+cZeT3VeNlnqE0kJDXg
	/yrFL8MXMEQ2mBLUyBDI7fyMQJbGQ01iBNll+OmT8w4Aic8pqo3bRMqSugRZlrOSTQ66yy9qCHI
	fcOqSwTiXKWwGn9RBkAdHb66AqHMM2bPikJRZd8p9ES+vWw0QAZ3rBILB3EPSHULgXWC7hmlR6e
	InnSqDTOUqZVcFiwX2jXUeR3EP0XqhBPASS/A0BwE1RMixvesDGVVVDPd4B6vHvKdWlZvtd7noI
	eYe9STR3SKHFA/Q95bN9UsnOgrNXs=
X-Received: by 2002:a05:6402:3589:b0:67f:9124:8815 with SMTP id 4fb4d7f45d1cf-67f912489c1mr3392806a12.17.1778494483376;
        Mon, 11 May 2026 03:14:43 -0700 (PDT)
Received: from gmail.com ([212.75.105.246])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-67ef0e2c317sm3566158a12.31.2026.05.11.03.14.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 03:14:42 -0700 (PDT)
Date: Mon, 11 May 2026 12:14:42 +0200
From: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>
Subject: [RFC 0/4] iio: light: add driver for Broadcom APDS9999
Message-ID: <cover.1778491503.git.azpijr@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This series adds support for the Broadcom APDS9999 ambient light
sensor. The APDS9999 is a digital proximity and RGB sensor with
ALS capability, featuring I2C interface, programmable gain and
integration time.

This chip is considered by Broadcom to be the 'successor' to the
APDS-9960 which has technically been discontinued.

The initial driver implements the ALS/Lux functionality using the
green channel, which approximates the human eye spectral response.

Sent as RFC to gather feedback on the driver structure
and DT binding.

Jose A. Perez de Azpillaga (4):
  dt-bindings: iio: light: add DT binding for Broadcom APDS9999
  iio: light: add support for APDS9999 sensor
  iio: light: add build support for APDS9999
  MAINTAINERS: add myself as APDS9999 maintainer

 .../bindings/iio/light/brcm,apds9999.yaml     |  33 ++
 MAINTAINERS                                   |   7 +
 drivers/iio/light/Kconfig                     |  10 +
 drivers/iio/light/Makefile                    |   1 +
 drivers/iio/light/apds9999.c                  | 325 ++++++++++++++++++
 5 files changed, 376 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/light/brcm,apds9999.yaml
 create mode 100644 drivers/iio/light/apds9999.c

