Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5982DECDF;
	Sun, 30 Aug 2026 20:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788121143; cv=none; b=t0tY4zsdABrdyzrdckPKbk51yd98Xr240dsunh4QECZHlrC7O4C1TlbvvlHcSSCbllo2zvcSvBcrr41DDUhe28awJl6tFk3YCfEkgu4HkXwixT4lgEikygSq6npsUdryGJwM3Mz3WdHMGpsME02MuH/9dp35GbGyKnTy0kImCL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788121143; c=relaxed/simple;
	bh=xisk9zcl4kv5FCPRU2cH6ngVuGMmImULxeXWsFd1Z6g=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=J5XNCjDB78db5rnsyFP65yhyr+ivKDbLWkLFMcQrz09A7sT6nzbMdOUuP3fEM5Ma4AKjj1S7IEQ3AIEvAjocfuxucLfHR8idL86UAWyoST1CanzmzLzR5uH74Bex/RxJ0bzTf7iGeOfpPC98mwgFF7sQQA/5uHQOfaRyp9VdpPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z6ZxWmC2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z6ZxWmC2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19CD81F00A3D;
	Sun, 30 Aug 2026 20:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788121141;
	bh=XP6R+Yg+TylQAhNN5dmgVZmEbDD+yZGA34fZK8IL/Io=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=Z6ZxWmC2KkqG7A0dVLqQUsl8z3mm+WXxPR3/3wQE/BxlIbFnWrfukx67oitOwLKNs
	 IQUsGq8huaim+uTMusDju5gceIk+X+dS5XznVvCdXSW6baJSooOtvwvtHeydGMc2qp
	 V6+QSIodLoiXdLn0VTQGvt9haZhz8UnU9ErHKGeH97x5a7H0oZwkSpU3rgG/4oQ0Yx
	 JOGb+4PNekObw8kQw+PNmv1Fu1tuIrpNpCuxI4/cJ1nNfVLvED2OXObxzLWxSJM6B9
	 HruoBA+X5mYeuGP7Re3SVR2VTtBmBJtS9ZLd+OfFdUAgi0uDTijzYWSCO0W/OCDyRV
	 uIOABwnqvCXqQ==
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 5/5] iio: adc: bcm_iproc_adc: use
 devm_iio_device_register()
From: Jonathan Cameron <jic23@kernel.org>
To: mdshahid03@gmail.com
Cc: Jonathan Cameron <jic23@kernel.org>, 
 Marcelo Schmitt <marcelo.schmitt1@gmail.com>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Ray Jui <rjui@broadcom.com>, 
 Scott Branden <sbranden@broadcom.com>, 
 bcm-kernel-feedback-list@broadcom.com, linux-iio@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260830170919.470974-6-mdshahid03@gmail.com>
References: <20260830170919.470974-1-mdshahid03@gmail.com>
 <20260830170919.470974-6-mdshahid03@gmail.com>
Date: Sun, 30 Aug 2026 21:18:41 +0100
Message-Id: <178812112192.2788519.6653263616832987105.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=698;
 i=jonathan.cameron@oss.qualcomm.com; h=from:subject:message-id;
 bh=xisk9zcl4kv5FCPRU2cH6ngVuGMmImULxeXWsFd1Z6g=;
 b=owEBfwKA/ZANAwAKAVSFNJnE9BaIAcsmYgBqlJAzL2T5/XDB3W+cqFxgEnJA44XHe8dJgIDlN
 BePdJ43M+uJAkUEAAEKAC8WIQRuKWazh4QGUpEmgbFUhTSZxPQWiAUCapSQMxEcamljMjNAa2Vy
 bmVsLm9yZwAKCRBUhTSZxPQWiAiVD/48XgFuZYiVviyFyM/YM2XzGouEBjYl12jdegstbH3HT7F
 eOXdpSAp1/amy71dwjgpoC3COuUe5kteOOafoBaJpTVfmGZ/te7VSvFT4UfZY/kE/YOMP8kcVX0
 JfPCAFITtmMpeCHRDulRyruRDJrYlBVFgADaJ0TJut7Uc8s6t+Dci4nwh366SsnVEncXU74kr9d
 BNgsIu5YFIIfUE+UUp3iQ1DYCnELpbGRJz+RGX0BsidSl1iHHHsAxJuBl/Bo64Nyb+njP0eypss
 jSfa1F+quWUP7331ERJhlW4f0d3OMCvkt2y8aM26Fs3Lp7c69Xk8n9lLb+z7faRL0V8hIhMVqTl
 PT25Zzr1Cs1L89r3c/rpgZ93oOrHbKbrqjE2bXsaqS8kQhsvy9UhUWfhZ8J2d+wmxob4qVyPNxJ
 ZS3fHYioLRFCFlkg8XNo14T893u5N2cttx9aiPGV5+8UeHE3fYPJ4M1KqXh3JxlAzD1HIRozD51
 PHnBOAJNSLLrYl3sj1frPKwnmiy2FhJWACfAn1BJaP5PbmkkYp1Iux5OoS97cCQrNCByvW0llMk
 W+qv2Tocl2ZdN8vRyCSuwr9nzXnOMcUmeLUh3RUYeFKP3bIvdlDB+Kyz/bK/U6TOqxSEyGKZb/H
 4xOrXkAKidX7JeJbHqtiEbWi5NFzRtLYjTHmB8w==
X-Developer-Key: i=jonathan.cameron@oss.qualcomm.com; a=openpgp;
 fpr=6E2966B387840652912681B154853499C4F41688

> Use `devm_iio_device_register()` to automatically unregister the IIO
> device when the device is detached.
> 
> This removes the manual `iio_device_unregister()` call and makes the
> `iproc_adc_remove()` callback unnecessary.
Why is the quoting here useful but not in the previous patch?

I'd rather no ` unless there is some ambiguitiy wrt to free form
text vs references to specific types etc.  That doesn't happen for
function names as () is clear enough.

If nothing else comes up, I'll probably just tidy this up whilst applying.

Letting this series sit on list until it gets a few more eyes on it.

Thanks,

J

-- 
Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
