Received: from mail-lr2-f33.google.com (mail-lr2-f33.google.com [74.125.230.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A744F3924
	for <linux-iio@vger.kernel.org>; Thu,  1 Oct 2026 11:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790853940; cv=none; b=m76/3OEExpt9HHro1mO8/w/XqRnAub0UEhUvouRW+Db11VPcDew5q9NSINKhC6vgmHgAsWNDTyP6+yWOyS4wIqA0JG4ysFaekPzPV+h3vjdD4kodmvmmttAUtJPRPueEaZ+pHA1DeFh9ywb+0K8tCmH5qgV+NZ6HkM8tV1CH2K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790853940; c=relaxed/simple;
	bh=XXJE9lpazIypG2rFZXwci5NBfeM4Y59+X+ByKH1vibk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R0dudZ7ZoAOjC2IjKmoZg8Lu9qtIrMATTRCw1TNYrhXfYfKDQSgIZdNY8nETjvHL49h93OxIW0gnob1438RfLOnwkQgKaaAg+5uol+5HiLqj8UIL7605Y5HfGCJRrK56qPDnKvKHz23cogTOAp0iS51UdZzVAZY5bvB3uEjh5F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g3Gee/19; arc=none smtp.client-ip=74.125.230.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g3Gee/19"
Received: by mail-lr2-f33.google.com with SMTP id 38308e7fff4ca-3a7847d8aadso5839071fa.2
        for <linux-iio@vger.kernel.org>; Thu, 01 Oct 2026 04:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790853936; x=1791458736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0q1MEXEb22UrsB8iQVi8Js6TB9YSw4vDK0ti4byYbGo=;
        b=g3Gee/19RPfSdyTFbWWXQO0RoOO4EIor3hvlWIbKklIDbxS1yJyBW0L7mQgN2ONPE0
         kkgdm9vGmd2rvYC8qpw2tmnpeQiEa0yTt/9muUKJGKYPLExveRZpabMfLDUFhwIcChDj
         cUu7drY5NT0smhq52LtvW2OJoXr61tv3sn+2UlcqTYFRSsBq9+lrnb8NZupGGMGqgWCV
         Q6T0+KaMguQW7PuWvzcE1LHifkirUt9J6YQKeQXbVR5BXwhC1C3Yn7iPhwz/kHXPMGJ9
         qoIfyJ9AHPJSvVRESuMFSB0l9CLFC1M9/YrYbHkvBcAuRFrm8R4aHlR7Wz0rzaw0FYD+
         SQWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790853936; x=1791458736;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0q1MEXEb22UrsB8iQVi8Js6TB9YSw4vDK0ti4byYbGo=;
        b=jTMwfYXWxgmrH/jzWxlEYOhz7uEu/0grCXFATr5QIWEGCQhi/jcv8HgwgFGn8oLpUi
         wV1QKaRTr1GADuE34EMBxy5XKmc3ZE+9EaDMuzygyAeqAHpuxHBPOqwIKjUAEnCCPbuI
         IISKCFZivjjWSjrh5AlcZBftfpa0irMrKy4yFpyWVhIRo3Of4RMOBTo89vUutXW0bf1d
         E35zLAFmWiYmK9NBhL4eveFOFAdKlB2+uG0dlwWVS2Uc1Lz6s2rgQuTD5mKdsIXoR3Nw
         s9tIgCxsCKV1VGVvyWmW1kuzYxp3cyRbXFD4+ks7CfM/d/UrDXYL/qlRSaMtwYa+K8Rg
         z0Iw==
X-Forwarded-Encrypted: i=1; AKwUvBzzZN8JlzBVbczJ2BS15/pRU7me3QxIUqqa9cPj2jswK4xrpQIGrhzhb+QYUaI3G3ZuHUrImbXF9HA=@vger.kernel.org
X-Gm-Message-State: AFq9FYLh6/iYkd4jooNPBURVEZ4dkxQZ8l856KYMpYroNFEQKEmy5PVx
	aUIrq+iKZJEp4jAvAkFwF3TM/yQkkZISUIQXNpUK3WxdWhnDCUheCc0w
X-Gm-Gg: AYBFou2a2HZ/viqYnK4pnbTi3HHlP1Qf0vqfpRzYDQ2WRZAKeDXwfRgOilOa0o5fWUe
	tnNACHZnY4IMDWAv+rtengnv1x/ig/w2JUp8YgWp/cf8Yj+sD4lxzvZ9nTxtgBdKJBM+7kSBPcG
	RALtTkaKmmAqInXELFmzKYIk/AbCU6/+TQRPvsp8Z76Wcn9KVfVgHxi1dbxjzE2pJEGKJgrHVl/
	BLGpQFooO0rH6OFg8b6kGPzLmC4N3ZO48YFnOJXvfw9u9fNAXU1l/LsBV0BZ++AFsRKROJnMDBq
	/hAxR4t9ldIHcwl/Vyq5QrlHRo21kIOuFWf5HCMYBWABjmKEXSJ5u4ZxmXVEB2gTI4FzfeT6JDe
	XIwHj/B7dO5StaU39WAfqFGLgxe7HqeuOna2n449ziwSE7eWIU250WWMCoN7ONLo6vZDV6iS59c
	72l9WoD9uf6TwNpohkpwLPymzdJnXlmWA90NEc5+bmYHThE8d0gxGrA7x5qtFEAMNeVRVUyA8jw
	MVt43t3fP3B78AlkCOmNGSCSSqNN3UkT5AnuCTRADM/8si85lkbcYmjmn7gEBhmSukLvA==
X-Received: by 2002:a2e:b814:0:b0:3a7:6f09:76c8 with SMTP id 38308e7fff4ca-3a779251d2amr9219071fa.24.1790853936130;
        Thu, 01 Oct 2026 04:25:36 -0700 (PDT)
Received: from yantra.. (dsl-trebng21-58c187-236.dhcp.inet.fi. [88.193.135.236])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a7717bd2a0sm14889991fa.8.2026.10.01.04.25.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 04:25:35 -0700 (PDT)
From: Rupesh Majhi <zoone.rupert@gmail.com>
To: andriy.shevchenko@intel.com
Cc: Andy Shevchenko <andy@kernel.org>,
	Bill Wendling <morbo@google.com>,
	David Lechner <dlechner@baylibre.com>,
	Eddie James <eajames@linux.ibm.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Justin Stitt <justinstitt@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH v10 1/4] iio: pressure: dps310: read buffered samples from the hardware FIFO
Date: Thu,  1 Oct 2026 14:25:30 +0300
Message-ID: <20261001112530.14594-1-zoone.rupert@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <arzl4DK8vhP0g8Hg@ashevche-desk.local>
References: <20260930100158.957977-1-zoone.rupert@gmail.com> <20260930100158.957977-2-zoone.rupert@gmail.com> <arzl4DK8vhP0g8Hg@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, Sep 30, 2026 at 01:35:12PM +0300, Andy Shevchenko wrote:
> On Wed, Sep 30, 2026 at 01:01:55PM +0300, Rupesh Majhi wrote:

...

> > +	rc = devm_add_action_or_reset(dev, dps310_cancel_fifo_work, data);
>
> Are you sure it's in the correct location?

Yes, it has to run before the buffer is freed, since the work pushes
into it. devm_delayed_work_autocancel() goes here in v11.

Rupesh
