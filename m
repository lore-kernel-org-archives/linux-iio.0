Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44A3448CED;
	Sat, 17 Oct 2026 23:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792279030; cv=none; b=sAZ8gX+TZJurkE7QoE2klGjbEEhQNQVBgg5WKZ0CyBF086B07P7vl7A1l1Hqssv40PkmzAqkYE2e9bDeUsYyVPCrq2kaLsEvV6nVmkuuXrGWcMUy7clAkSm6qdOWo9W5fsWescLqNVmDKTodAqueAxllvQAlEaG181Esz5sGkEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792279030; c=relaxed/simple;
	bh=E+vwgwxUYmHGNDMDq3oL9pWFcLnI+oBwhJX/6sJn9Sk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E+XuswTegjGpdsgMniUD3mL7Fmu6sFMshYwO9DXnNEHAfEzna1v312435wnKapYrPE2+D3u8D7lONO73IrR/oK2G2HVkiFa9umxKvsOrjy0xS0WurLI3DhatUjaUxA8S/fXpKVfmNaLWFg1BW8MebYOnb+cbjsN90vFeXDfleg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oV0/zFO+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oV0/zFO+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 973E21F000C4;
	Sat, 17 Oct 2026 23:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792279029;
	bh=fwIRFmThBv/Bf3eugia9PxP3kDcCChmUtw/z14sqLHk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=oV0/zFO+N+Hp+W2f3auxh/xGoZOthdqMSQ2Y+6EBWASpN6Imac0+VjngQNuRw+o8v
	 kOyPypHIA2/KVq7xvz/UcObNIoYhzS2j0xlbbih78+ZMIhaQjfM5Zdsect9aDEuUak
	 beQk7Rq738vQtLX19lv8lEy/nnf/R19M1KSUsFyeCw7AVnJsO/9AhlrqZ55qltpnhu
	 EOmVTdzFJGVqSTFEsVHoSDbVgKrTakN3xTUyfGPUYUWv6otyPzMQswDOrbuufBN4ly
	 PZb9bInH0rzIGSNf79iIiJeIGOLhczFxjoxtzzrl7awJBc/UZCzj/QhsKUOLah+Fde
	 d0DJwUu/UT5Bw==
Date: Sun, 18 Oct 2026 00:17:03 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Arnav Kapoor <kapoorarnav43@gmail.com>, Jyoti Bhayana
 <jbhayana@google.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>, kernel test robot
 <lkp@intel.com>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: common: scmi_sensors: fix truncating 64-bit
 divisions
Message-ID: <20261018001703.5b83cd35@jic23-hlaptop>
In-Reply-To: <atEvb5jQsZCywGKs@ashevche-desk.local>
References: <20261006045244.13993-1-kapoorarnav43@gmail.com>
	<atEvb5jQsZCywGKs@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 Oct 2026 22:54:23 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Tue, Oct 06, 2026 at 10:22:41AM +0530, Arnav Kapoor wrote:
> > do_div() divides a 64-bit dividend by a 32-bit divisor: the divisor is
> > stored in a uint32_t on all architectures. The driver passes 64-bit
> > divisors to it in several places, so they are silently truncated:
> > 
> > - scmi_iio_set_odr_val() divides by uHz, which exceeds 32 bits for
> >   sampling frequencies above ~4294 Hz.
> > - convert_ns_to_freq() divides by interval_ns, which exceeds 32 bits
> >   for update intervals of ~4.29 s and above. If its low 32 bits happen
> >   to be zero, this is a division by zero.
> > - scmi_iio_get_odr_val(), scmi_iio_convert_interval_to_ns(),
> >   scmi_iio_sensor_update_cb() and scmi_iio_get_raw_available() divide
> >   by int_pow(10, n), which returns u64 and exceeds 32 bits for n >= 10.
> >   The SCMI exponent fields allow values down to -16.
> > 
> > Truncation results in wrong sampling frequency, timestamp and
> > raw_available values being reported to userspace.
> > 
> > Use div64_u64() and div64_u64_rem(), which take a 64-bit divisor.  
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 
Hmm. This came up before but they never came back with the code
fixes asked for:
https://lore.kernel.org/all/1644395873-3937-1-git-send-email-wangqing@vivo.com/

Anyhow, this looks good and I haven't heard from Jyoti for a few years
so will pick it up without waiting for a tag (most welcome though if Jyoti
is still active!)

Applied to the fixes-togreg branch of iio.git 
