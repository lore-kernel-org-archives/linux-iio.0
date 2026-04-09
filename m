Received: from mail-106121.protonmail.ch (mail-106121.protonmail.ch [79.135.106.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B059A34C83C
	for <linux-iio@vger.kernel.org>; Thu,  9 Apr 2026 21:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775768428; cv=none; b=GnhJ46v5MFC92n+39oNddle7aKU7rhrKiyIKq2bdc5JLc1VedaNa/C/sejlD2dWJviXloeQXPR2AB8vBHVXWIMTib9HGDcto0dRWG4s3GA4fF1lgsPcKSCeWABDhWJHeRl75cDVmysZioCTQMn6WgJ1VbbEk+G4QlAk0xVBetE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775768428; c=relaxed/simple;
	bh=Nm7JgBBzKfSOpCaNinjZMRqGAUGu3X2p6hu63BxBNig=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BcIc++3kav5m4qlIxveF3m8n9vjd85ZKoahTE6kmYn2yyHnb+OqhjN4PIiqX2WSIMsErItrayApgeneSGLSUoqkykWyLUmTdYFtnpr7rT/n7EWz/2yuPluYB8SkVRFLGrBhOOIgsYiDTLIeeEXpr3S+Tfidm7jOFZDTS+P+t/p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=N5Y93nT9; arc=none smtp.client-ip=79.135.106.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="N5Y93nT9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1775768424; x=1776027624;
	bh=Nm7JgBBzKfSOpCaNinjZMRqGAUGu3X2p6hu63BxBNig=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=N5Y93nT9+ogqqCt9cglQPq5+4ZMoZbJUHuKZa2SbqbGApvxAvXnFMYKbek64T2Jyf
	 5xHYXzNLLE0gtTyfXLwt0+2GLKpyWhPDG73muYralBgxzKXS+21AJJg3dEBnk3uvfQ
	 XQ1l4Kt5vgWFAiRVro4gXWmerctkmx7LWcGsGcP5W9kIgn1vkiX+A0bTRJE20MfrTi
	 pkm9vJnKuctSagieJ/VQYKXHVQ9UGeLFvS0oI6P/PO5rYOWw6PX+83x+BEXMqWDWbP
	 dsNtbBt/41ecCijZVbdLGQG+NyTFU7L7FkTtiTfScLbirY1h1o/hHbrlVRrgjFG9CA
	 p1K7m8XwOUfww==
Date: Thu, 09 Apr 2026 21:00:17 +0000
To: Luka Gejak <luka.gejak@linux.dev>, Hardik Phalet <hardik.phalet@pm.me>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From: Hardik Phalet <hardik.phalet@pm.me>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, =?utf-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Brigham Campbell <me@brighamcampbell.com>, Shuah Khan <skhan@linuxfoundation.org>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH 3/4] staging: iio: magnetometer: Add QST QMC5883P driver
Message-ID: <DHOXD5OXVBU2.1RY6GT1911U9Q@pm.me>
In-Reply-To: <DHOTF8P1AES3.1S6IAZC3X833T@linux.dev>
References: <20260409162308.2590385-1-hardik.phalet@pm.me> <20260409162308.2590385-4-hardik.phalet@pm.me> <DHOTF8P1AES3.1S6IAZC3X833T@linux.dev>
Feedback-ID: 166659585:user:proton
X-Pm-Message-ID: 3be7cd935ca404a974041f5e90fd6300ba5f9828
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu Apr 9, 2026 at 11:24 PM IST, Luka Gejak wrote:
> On Thu Apr 9, 2026 at 6:24 PM CEST, Hardik Phalet wrote:
>
> While functionally correct, the standard kernel idiom for deserializing
> contiguous byte arrays is to use the unaligned access helpers. Consider
> including <linux/unaligned.h> at the top of the file and using
> get_unaligned_le16(). Also since it returns a u16, you must keep the
> (s16) cast. Something like:
> *x =3D (s16)get_unaligned_le16(&reg_data[0]);
> *y =3D (s16)get_unaligned_le16(&reg_data[2]);
> *z =3D (s16)get_unaligned_le16(&reg_data[4]);
>
> For iio sysfs attributes, the dev pointer belongs to the iio device
> (&indio_dev->dev), not the i2c parent device where runtime pm was
> initialized. Calling pm operations on the iio device will lead to pm
> refcount imbalances and potential kernel warnings. You should use
> data->dev for all pm_runtime_* calls inside custom sysfs callbacks.
> Something like ret =3D pm_runtime_resume_and_get(data->dev);
>
>
> You should change these to use data->dev as well.
>
> Your dt-binding correctly documents an optional vdd-supply for the
> 2.5V-3.6V rail, but the driver never parses or enables it. If a board
> physically powers down this regulator during system suspend or relies on
> the driver to enable it at boot, the driver will fail. Please add
> devm_regulator_get_optional() and enable the regulator here. Also, you
> should ensure that your system resume callbacks correctly re-apply the
> chip's initialization sequence if power is lost during suspend.
>
> Casting function pointers like (void (*)(void *)) violates strict kcfi
> checks, which will cause a kernel panic on modern architectures
> (like arm64) compiled with cfi enabled. The pm core already provides a
> safe helper for this. Plese drop your custom qmc5883p_runtime_pm_disable
> function and the devm_add_action_or_reset call, and simply use
> ret =3D devm_pm_runtime_enable(dev);
>
> Because you use devm_iio_device_register(), the iio interface is
> unregistered automatically during the devres unwinding phase, which
> happens after your .remove() callback completes. This creates a race
> window. A concurrent userspace sysfs read/write could trigger a pm
> resume exactly while or after remove() is putting the chip to sleep. To
> fix this, create a custom devm action (via devm_add_action_or_reset) to
> write QMC5883P_MODE_SUSPEND to the chip, and register it before this
> devm_iio_device_register() call. Because devres unwinds in lifo order,
> this guarantees the iio interface is fully unregistered before the
> hardware is suspended.
>
> Once you move the suspend logic into a devm action in probe() (as
> mentioned above), you can delete this qmc5883p_remove() function and the
> .remove hook in the i2c_driver struct entirely.

Thanks for the thorough review.

All the points are clear and I'll address them in v2.

Regards,
Hardik

