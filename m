Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A883101A6;
	Sat, 17 Oct 2026 22:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792277438; cv=none; b=DTCffQWIVJVrf3r893vh/PwIXGj7WoG17M929U3B+bDmDekj7xNVX6UFse/3fcl9xBGD1SEPPqQCDWb3dVN/mnxr3VBEpCyqd8nn3tMDdMjULCxQzyxndDytwxiGHgV5Vw5+AVl3Ya1MdjVCCCc1rDdTvTVPfQQtblTknWRzVCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792277438; c=relaxed/simple;
	bh=2huRyb511I/fbFVfpMx+u+gjUiD+TkXAkyZEAfcoY/g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ka33/RcCKLC6a0/VQjFzY6u37rYVNhI+PQZdspUYqpaRI27qCw/PIEbkaxsr4/0qI2eCyrceY/tBRAy5qZjeDaEG47uxVTrTohhek9fGZDPaDmL2dj1KN9mHoCtf9TsbNIXhgye11HbLJoMuMcjh7MOcuSc4SYQH+NDwi2t1v4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gFNtQCcL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gFNtQCcL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89A891F000C4;
	Sat, 17 Oct 2026 22:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792277437;
	bh=XA2/nCO3xUkKtTtK4FQ/ig+L5NOAUQNM84JZ76wr3ZI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=gFNtQCcLE888mAu+4eGZ7GPJgpIL/zN7dP91hAYwpvSvF8Z9yUYADGrceZNjbCtCt
	 soQCo1kRyGaBIASYft7xucN972YQoN/DqE1PYegUo+XaQdkioWsTj41TtvQdihjxhF
	 +XAYtr/eS1Y8EWN0je10UpvPkQWPPgkJVUK1ViDcog2sYU20fjKjVRSonE7MaOmW9h
	 rr3pPI64b0LY0f065BupDG2C3eWDkMASPAICxSlKMohcq0ThXZbXXvt/hq46676zbO
	 1mQ2GUb3+laOLljhPB0KrHXOSDIZradAq7ZIWiAHQRZ8Ehxk7Dnwx30p56gnAs/jX+
	 KHH6fkjQvhU5w==
Date: Sat, 17 Oct 2026 23:50:32 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Alencar via B4 Relay
 <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: rodrigo.alencar@analog.com, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, David
 Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH RFC v2 0/4] Add E notation support to kstrtodec64() and
 IIO sysfs writes
Message-ID: <20261017235032.693e9eca@jic23-hlaptop>
In-Reply-To: <20261013-e-notation-v2-0-d4adb5e193fc@analog.com>
References: <20261013-e-notation-v2-0-d4adb5e193fc@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 13 Oct 2026 10:36:43 -0300
Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:

> This series lets kstrtoudec64() and kstrtodec64() accept numbers in E
> notation (scientific notation), such as "2.7e9", "1.5E-3" or "1e+16".
> It then moves the IIO core fixed-point parser over to kstrtodec64(), so
> every IIO channel attribute written through iio_write_channel_info()
> accepts that format as well.
> 
> There are two main motivations:
> 
> 1. Shell usage of sysfs attributes
> 
>    Some IIO devices take values that are long to type and easy to get
>    wrong in plain decimal. A frequency synthesizer or DDS might be
>    programmed in the GHz range, and a scale might be a tiny fraction.
>    With this series one can write:
> 
>      echo 2.7e9 > out_altvoltage0_frequency
>      echo 1.5e-6 > in_voltage0_scale
> 
>    instead of counting zeros in "2700000000" or "0.0000015". It also
>    works with shell tools that print in E notation by default, such as
>    printf's %g conversion ("printf '%g' 2700000000" prints "2.7e+09")
>    and awk, whose default output format ("%.6g") prints
>    non-integral values like 1234567.5 as "1.23457e+06".
> 
> 2. Userspace software that formats numbers automatically
> 
>    Many languages and libraries switch to E notation when converting
>    floating point numbers to strings, without the caller asking for it:
> 
>    - Python: str() and repr() of a float use E notation for exponents
>      below -4 or from 16 up, e.g. str(0.00001) == '1e-05' and
>      str(1e16) == '1e+16'. Writing such a value straight to an attribute
>      with open(...).write(str(value)) currently fails with -EINVAL.
>      The same applies to NumPy scalars and to f-strings with the 'g'
>      format spec (f"{2.7e9:g}" == '2.7e+09').
>    - JavaScript/Node.js: Number.prototype.toString() uses E notation
>      for magnitudes from 1e21 up or below 1e-6, e.g. String(1e-7)
>      gives '1e-7'.
>    - C/C++ applications and bindings that use printf("%g") or
>      std::to_chars() with general formatting, as well as MATLAB/Octave
>      and other numeric environments that print in a "short" form.
> 
>    Today these values have to be reformatted by the application, or are
>    rejected by the kernel without warning. Accepting E notation in the
>    kernel makes the IIO sysfs ABI more robust to this common
>    behaviour.
FWIW reason for the feature looks sensible to me.  Thanks for laying
out all this detail.

Jonathan
