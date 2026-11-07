Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794013444;
	b=RdO3O1NUuMI8gHX7lf4LmHkA+svH5hjRu8ubjt3b4PXXQ/Qx6KIfqtgFMNlFuC7L/QLj
	 N2KsM1qgd9ovrHy2GbvMTjxAeVa9j3ItlynHQ+Es45Mv6f8jGoMMmx6MDPuec9ryWJ5Zi
	 d8B/Gv4a8pOCixec9x+KawGChDU9x5k934V179fYVYyPHGLSnQDywin10ZQaTxV99+meK
	 ziUWBEgfEUhISdjaGDRreddF1ZcXOBWwYq/e454tdfkjq5KcXhrv51ShLyNAMc3bEYnbC
	 JRwlBZhJ7sCRq5rJzr6DIJjr2/xeRCCiw6/2WgPMTWSEoM34N5ojjdbpbWal/4UBH2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794013444;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=xSABotSf9eGOgeEhuxBGujWoU+JvUjNA0CDmsTEXxtU=;
	b=P9P/Zjn74zXkSKAs1VGFzLxWvmTw0gnZPLzVWMujm9aGjKjXjzItgwRtheSjr7AjKnXV
	 Rt+9PngqBMNCMptllgHZ8O3t6ttqEuKGcyJHDyb5ZdjSDJaPLOC11KRjCaetXOAouu3+U
	 eRaak/0o/vh9uXwkE6zsRm4Z2b01t5PALm4GL/hMjUs9+tLuBQ3USn+eV80hAiiwNx/P+
	 foYL7bYrmDxGO8/Mv3I1Z+6CNnp/t4SledsSXRU+3RLC6l0au79GjNahVSkfVVYPd2UoG
	 S+oWWO5FkTKUBRxwO0tnCJPr1CA1329Mc4kdi1wUKOk/ioiLrQNXXQb22lhz6FdcVyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D+O6wpVV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29060606A32C;
	Sat,  7 Nov 2026 01:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D+O6wpVV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD8BA1F0089F;
	Sat,  7 Nov 2026 01:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794013444;
	bh=xSABotSf9eGOgeEhuxBGujWoU+JvUjNA0CDmsTEXxtU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=D+O6wpVVaOdJbSDeaxoUlfP5e4LIp8EX2r1a4AiOfVbbqES4lFOtisPle0bK9E7ot
	 FqODWb5EP5bFV1oIlqhZihY8yqIrDxbvS5SrS/JTlyHZMiOWHsH2r63Yra/Fobo2W1
	 zkyJf08uDJjjxp1yuanTwgJFXpjsjJRRkXTWNu+EGgHuyOMK4ISJ0mdhE3eDs7xqd2
	 uXvdTfNyeD4jQecULRCAR4sccSr4pAqNXLq7X8zKllD0dsBFKTTEaBHqWuMnCFqRQT
	 aeq1Y9IQua00/+xGriU8eHYjBZprKvIXznnZfiUzcTtCTHh+OxVqBnIcAikhXmlh9P
	 f0AaT7SNWGs8A==
Date: Sat, 7 Nov 2026 01:03:56 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Daniel Balint <dbalint@google.com>
Cc: Benson Leung <bleung@chromium.org>, Lee Jones <lee@kernel.org>, Tzung-Bi
 Shih <tzungbi@kernel.org>, linux-iio@vger.kernel.org,
 chrome-platform@lists.linux.dev, mfd@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/3] Introduce cros_ec power monitoring
Message-ID: <20261107010356.39d9eddf@jic23-hlaptop>
In-Reply-To: <20261106193129.43493-1-dbalint@google.com>
References: <20261106193129.43493-1-dbalint@google.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  6 Nov 2026 19:31:14 +0000
Daniel Balint <dbalint@google.com> wrote:

> This series adds the ChromeOS EC On-Device Power Monitoring 
> (cros_ec_pwrmon) driver to read onboard power-monitoring ADCs,
> such as PAC194x, wired through the embedded controller (EC).
> 
> Several ChromeOS platforms are equipped with onboard ADCs that are
> connected to the EC via I2C bus. The driver interfaces with the EC
> via the existing EC_CMD_PWRMON host command API (and EC_MKBP_EVENT_PWRMON
> events) to manage ADC accumulation and expose accumulated per-rail energy
> through an IIO sysfs attribute.
> 
> The driver is only loaded when the underlying hardware feature is present.
> The series also fixes alignment padding in EC_CMD_PWRMON definitions.

Hi Daniel

I'm not necessarily against this but when adding monitoring components
to IIO the usual question is why not hwmon?  What features are not
well supported by that framework?

Note historically I suspect we accepted one or two drives into IIO that
would have fitted better there so precedence isn't a strong argument.

Convention for these somewhat borderline case is +CC hmwon maintainer
and list as well as IIO with that explanation in the cover letter.
That avoids any last minute surprises!

Jonathan

> 
> Daniel Balint (3):
>   platform/chrome: cros_ec: fix alignment of ec_params_pwrmon
>   iio: adc: add cros_ec_pwrmon driver
>   mfd: cros_ec: load cros_ec_pwrmon on supported ECs
> 
>  .../ABI/testing/sysfs-bus-iio-cros-ec         |  13 +
>  MAINTAINERS                                   |   7 +
>  drivers/iio/adc/Kconfig                       |  11 +
>  drivers/iio/adc/Makefile                      |   1 +
>  drivers/iio/adc/cros_ec_pwrmon.c              | 333 ++++++++++++++++++
>  drivers/mfd/cros_ec_dev.c                     |   9 +
>  .../linux/platform_data/cros_ec_commands.h    |   2 +
>  7 files changed, 376 insertions(+)
>  create mode 100644 drivers/iio/adc/cros_ec_pwrmon.c
> 
> 
> base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4

