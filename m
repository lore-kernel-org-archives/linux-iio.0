Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A7734F46F
	for <linux-iio@vger.kernel.org>; Sun,  9 Aug 2026 16:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786292655; cv=none; b=qICjEvQ6kdQoqxbS5L36fQJob276eR66JYgMuaEP4J6osBdLNAyd/of8Ywg364XH1LlGIhdt9/As5QEY/h0/HZH6Zkjwp6vC+PTeExWLJucCeWzkTn08qTchYwy2iPF3sR4eFOBeg2qFKKenbANUkUdmDi0ztSISiG00TFjUIbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786292655; c=relaxed/simple;
	bh=L8jVhzcEx/1Ri/TiJ6hXDYJPVTTnzDVvCCZJTFtQQNw=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=hW4ItO5hkEXEIGVqOnJYh5UgE2MejHDVHtVy7QQ8HTLmfEt8TxOUItd1MJiW/nLc3BcoZEOMkzAkXiJ+EQHE9LVRXBPrNcFd5iXqDBRrvcvoy8bkNut0GSuaWNOI4D67m6a0Nv1kX30C5NY/x0Hnv/XOboZ6CBK49yK64C5pKF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R00Blv2j; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R00Blv2j"
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-5c39cb2115cso2572533e0c.1
        for <linux-iio@vger.kernel.org>; Sun, 09 Aug 2026 09:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786292653; x=1786897453; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=L8jVhzcEx/1Ri/TiJ6hXDYJPVTTnzDVvCCZJTFtQQNw=;
        b=R00Blv2jCyJ1JHvOuRWxIirbnXSieJQnaFuU2qIecCIGssL2OXmby9NhkIpXoGkRHv
         V4nUCAP/zl9IUOas4zwgcMDvP73s5uLLWL6rdtod7P/3TKnxcEkEAG7HVcy9ycyioDOt
         gAApCeEgS8qZ81mk1iFxSACvDPGQ/eTM2qtA3l/Wz8iTnzo18Vi6Dwz7XCWdC9g+j7QV
         ClZVK+56rnmJ8HyMwTURBkICw4WGXy6U7u8Jk9R3iaTg5JmtLFu2HoxT/TM0XfDHTz8R
         TuBoUkQrcEsJYQUH2Sn9miCwmkUGudqDOELVw1UaQk+hJZKMZdilOMaZH7EChD+xLJ5J
         5KGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786292653; x=1786897453;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L8jVhzcEx/1Ri/TiJ6hXDYJPVTTnzDVvCCZJTFtQQNw=;
        b=GVHWJkgcqIH+CLt+zzDwjsReNR1B7oieC3lG04yldQ7j1y4X7EFJFikjb8PuOdug1d
         27CbdmBWzJanRhPXBcQi4VoG0iIyoEtF9xwPWgUBpo+8gVIZ7oWtco7HhdTz6y5hlxTB
         NeQAYDH/lFPH6ZnQZlq1bO4Zer7pfxYtNyKH4ZaBVWrDYLYqutsa6zMMSVso03eoNTjj
         5wiAus27J+hL2WXNCsy71q0e7OYlao27t1pdfP9BPUniw+aAfocImY8sgnGPeL2TR3x9
         +lU98UwwFKQ45NpISqYr5eg7evoVO64E1SOaz0DrnTarUDl07he4wmUk66QeDbaysElp
         qtEQ==
X-Forwarded-Encrypted: i=1; AHgh+RpD2ozTIUt2hgb2MvLaROrgyVagg5zH0WH8pfBKwk9upAzyHJz/BfJmICnuxKGb9pVuGrp6DfGda1o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxT/fIPMdtIAjgzIFH7mYpWhtQRN5IUyAKA8XLNlrM4pRLM0xnn
	sSea8JUNFxuMvSylih+XbA5GMrIXWsec5VPsbC8xDjTAlEYFrCOELf9W
X-Gm-Gg: AR+sD1146TrTViai33baWctUbr+DaDabwYy3ZBS2AAZic+/nocCkHMl19yCczT63Uj6
	9EuSi/K64/Af9TuyyR8jgYzRIOM+27rAR1Rhr8YrO0XX5b4x7EwwE2BBob9Inm6TSDVrVUNvxX2
	nimLQpa13Wzse4hf8iMui6viDN0UVi8/IkoXNR3DsFzYc5SfdRXfRbuOAtWWI/oFPLJaTMVMpjD
	hVcFxPyivzne+O4JYSce9bREPXAzLAvAT0+RMOhu3KQ2qL3883sUnbeK+d+SjHrf1BZlX3FMf5N
	ypw8rqPzs5o0ptwLh7DDOmDokMvFTK1f9JdsQfGdBdNzJyB3w1KA8sB37GNrWBm6WLgA7SMCZSD
	/BGFnpO/D7moOlG/HbrGARbhSbBMSjh4QM8VCWYnB38VQ3HJhyIgbni9Np5Rwakwpr1l2FOYdF/
	dK2AVgWdA/tFbRp1v4G4j2fYBRndTtjdIVXRav3d6aUUu9dQ2SUXg=
X-Received: by 2002:a05:6122:2385:b0:5c2:c79c:c093 with SMTP id 71dfb90a1353d-5c4152d5cf1mr1326569e0c.5.1786292652899;
        Sun, 09 Aug 2026 09:24:12 -0700 (PDT)
Received: from localhost ([2800:bf0:82:11a2:7ac4:1f2:947b:2b6])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c4133821e5sm2592233e0c.18.2026.08.09.09.24.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Aug 2026 09:24:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 09 Aug 2026 11:24:05 -0500
Message-Id: <DKKJW8KLSTON.18355X0IQHY5C@gmail.com>
From: "Kurt Borja" <kuurtb@gmail.com>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, "Kurt
 Borja" <kuurtb@gmail.com>
Cc: "Jonathan Cameron" <jic23@kernel.org>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley"
 <conor+dt@kernel.org>, "Linus Walleij" <linusw@kernel.org>, "Bartosz
 Golaszewski" <brgl@kernel.org>, "David Lechner" <dlechner@baylibre.com>,
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy Shevchenko"
 <andy@kernel.org>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-gpio@vger.kernel.org>
Subject: Re: [PATCH v3 2/9] iio: adc: add the ti-ads1262 driver
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260807-ads126x-v3-0-f89925d72792@gmail.com>
 <20260807-ads126x-v3-2-f89925d72792@gmail.com> <anetMEd_kLs1YXwu@monoceros>
In-Reply-To: <anetMEd_kLs1YXwu@monoceros>

On Sat Aug 8, 2026 at 5:28 PM -05, Uwe Kleine-K=C3=B6nig wrote:
> Hello,
>
> On Fri, Aug 07, 2026 at 10:58:24PM -0500, Kurt Borja wrote:
>> +#include <linux/mod_devicetable.h>
>> [...]
>> +#include <linux/spi/spi.h>
>
> Please rely on <linux/spi/spi.h> to provide the structs of_device_id and
> spi_device_id and drop <linux/mod_devicetable.h>.
> <linux/mod_devicetable.h> is planned to go away soon.

Thanks for the heads up!

--=20
Thanks,
 ~ Kurt
