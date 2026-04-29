Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD6E3F7880;
	Wed, 29 Apr 2026 17:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777482683; cv=none; b=UHpZamc6lNH/NVD8ItgYIysM+Wn6dGuiaQmASofLbrYekB+atoC9rZ9eb/glttr5mJbYmHiCMGF0DW6i4mzbOEbsDCgPpj+miPNlIomfW/MH0jU/KBbTKZQjVKnqUQivSHJT7bQffLQf/jp2VbGRbGabyujKZ01cYIMLjdw1ZjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777482683; c=relaxed/simple;
	bh=fxCaP6a1NoBGyt86DfYoB/QC+z5/uXbopaWM2cgC+mU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ouHzd4fn04mOm6HdniW8XjDh0UpJkwBQZqAJBO3bN1YXqWDIs6AMnjAyA6HbDyVgbT/yHv4c1YyBDzPxpPcMLbGCfq+r7k/XhvLVZ1QOoeHZElBEq0qm1/wHt96N4dJnfFRQLPNiQtf9Fw8V//yVnuZ7qg3BOJ9L2jwd2hIM+Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AcRchuwJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AcRchuwJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34FFDC2BCB8;
	Wed, 29 Apr 2026 17:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777482683;
	bh=fxCaP6a1NoBGyt86DfYoB/QC+z5/uXbopaWM2cgC+mU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AcRchuwJHBZ2+UA0xbngmF+GRrhzKSM6p6sz/SYaLyjlP9OX9H9vEaHWimhA35nyu
	 HSW0g/T4soiFwa2of9FADVo7b9E8+56qPlZKnxSmiSlLy7td42un0LlDhKy+2CZai+
	 GQCTqDBxDiBcr++1bzSrLZ6CiRtbIps5WCO+obCj3QbOws3BoKBt2+8CIPIF7kBalk
	 6GnvD+LYhTHX+4wG/MlPQkHIJVvlghTnHWBaPaWRM6S10prZ7DJ/jYbklXqxxzT4cz
	 kcO32ZciEJYKDlBektNzTgDgFeA4jQn0FKGqKmfgNGlUT2NRSHKNNA+VLmyDp4YK8G
	 28t4XVg9hwQoA==
Date: Wed, 29 Apr 2026 18:11:12 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>,
 rodrigo.alencar@analog.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Stefan Popa <stefan.popa@analog.com>,
 Jonathan Cameron <jic23@cam.ac.uk>, Greg Kroah-Hartman <gregkh@suse.de>,
 Michael Auchter <michael.auchter@ni.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, David
 Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Rodrigo
 Alencar <rdealencar@gmail.com>
Subject: Re: [PATCH v4 05/13] iio: dac: ad5686: fix overlapping DMA buffers
 in I2C read
Message-ID: <20260429181112.3b6c263f@jic23-huawei>
In-Reply-To: <afIMm2x2iOUctCY4@ashevche-desk.local>
References: <20260429-ad5686-fixes-v4-0-bb8f1cbd68e1@analog.com>
	<20260429-ad5686-fixes-v4-5-bb8f1cbd68e1@analog.com>
	<ydxol7bwgvhxrw2zafaplzvk4kmnbvj2lzyfioh2lhfrrrxx6o@zsbw4mtx7gly>
	<afIMm2x2iOUctCY4@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 29 Apr 2026 16:50:19 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Wed, Apr 29, 2026 at 02:12:32PM +0100, Rodrigo Alencar wrote:
> > On 26/04/29 02:07PM, Rodrigo Alencar via B4 Relay wrote: =20
> > >=20
> > > The TX and RX buffers in ad5686_i2c_read() both reference data[0], ca=
using
> > > byte d8[1] to be shared between the TX buffer and the RX buffer. I2C
> > > controller drivers that map all message buffers for DMA before initia=
ting
> > > the hardware transaction will map overlapping memory ranges with
> > > conflicting DMA directions (DMA_TO_DEVICE and DMA_FROM_DEVICE). This =
issue
> > > was reported by sashiko. =20
> >=20
> > Do we need a proper reported-by tag here? =20
>=20
> I asked Roman (in another email thread) about dedicated email for that.
> Let's see what he is going to answer.
>=20

=46rom that other thread use:=20
sashiko-bot@kernel.org

