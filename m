Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7AB31F98A
	for <linux-iio@vger.kernel.org>; Sat, 22 Aug 2026 08:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787385926; cv=none; b=U0kNbjcW8REU/7Q8uC057uyupzz0/1ZIK0FEiPRp7RDGWTUjUOUgc5jjZm7Ebk2n1JBlCPuznQhlpAT977a+BSTv7IS/HoYQCWYkq+89Rl0bxtlqgsZnezeMxmS0YTEuK5YN6j/1BAVNQBsfaDMCVAHNGv3NiQJON4O3x1UQJ80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787385926; c=relaxed/simple;
	bh=GoX7oXsNlvzStweykm47aboyQ60NH9edt6IeKqqks8E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ib8LXi1qTawWhHYVm0VATCASKAo7x/zVzRsjQwFeccrWdqX/0xxS4zCH7bnOxTBfbY0IoJdNWGBPU6ZygKOt+lBzwzD2JoEKU3ddic97qmdAlfgOQemDJ2TL9fhSo0Pg2ICsPU7rjfJ1G/zIOifH7Gvmv4P7emQrPRvLphUb/es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VKIugR7V; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VKIugR7V"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c214321dc32so355155966b.0
        for <linux-iio@vger.kernel.org>; Sat, 22 Aug 2026 01:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787385923; x=1787990723; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/DwAn7P/v0Ku0NHmQViUiZ0vUb0YJHt5XOnacRA78dQ=;
        b=VKIugR7V+4gwnMXtknTMpF/VDmEbFk/tyXGhtimqn9gYFNjchvwp1sWT1vSo0l9xg3
         Htz+SW1vfEI+2iYZjaLPqzEWt4Rg/OYU3Cz0Qe2sBPU3J+NjrElg85vBrc0VQYH0gW3X
         kf6BCgCnW1OMKHVeLQ/l7M+d0IThN48zxF2tBSiQoIlNzYw5zyqjq6eOdeT6H5f93ZFO
         VVAyK9yTT+YBOUlOh36LPm3Zit4mw+cKW3LMJLanioka2rOim+4c8RiqaDwh7ODFvfMp
         yNnPclcs9YRyc7k4bEthrT5/OGULgxSwilVTz0qVMrabsI0f4UBRJrpiGqEXMh1RAziX
         hILw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787385923; x=1787990723;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/DwAn7P/v0Ku0NHmQViUiZ0vUb0YJHt5XOnacRA78dQ=;
        b=HhmN1BqP+jrO7gK7pbIl/W+o3TS7G0jcfJsYVamYkLQEFRgJ34yayPL7oSOLRba9bh
         sbI0xAQKqJNYPZDr06LiMFUOO2pn70DUEwa0Kf9yUoyooKDg91wwXFGmvEjoXRQ1OKqX
         TCr247Lg4eRAwXk/5FeirPHcLrErpeFdV1rmxJgTkAikRcgQKEcKg8eqrhpetg96UTo0
         lVAaOwhIFCfzNeouMnxshWaUTduxKfHfyG5mWb/09i1DpHgImR6yBqOEMDreswlPji5V
         OvJrTAYpAd+AjFSCNVwMNI42IfYtc7KhMMW6hv76TzJLDxkr3+9f1KwJqsID0bP695qL
         dGSg==
X-Forwarded-Encrypted: i=1; AHgh+Rr719xLpIa9T/GwY9ONGacoHrjJAOzOxnIQvCUGp/eF0LEXDF1c5YB6hco7+53ljbVpPACnx44Nf5c=@vger.kernel.org
X-Gm-Message-State: AFuF++kwIQ/z2j2OcoexhapVnQHI0yUA/F5gIW0BJp4y/azYdFHa8gPV
	a7yDCuTXqKUINGsgdscB2iL60vIPa78Z3olWvuy5sbSseNGHVEee1S2t
X-Gm-Gg: AR+sD112U62oQybKsQ3f6/HZt9QFMBco/KPixDucdtnGFHSYfuPfWjlysAMmj2CM7JZ
	bSso83NeTByB177nxNyLTY6fEyYby6+k99kRu4dwAcRAE6tfMx2GUpjc84D/mizsPWzYll5YSue
	tGqfmC/j0y11Vc7iC06eM5jzBNcu2438w5s0WgoXV+SNFVxo53KXWcleSnmZQaPDncAACNBnL8t
	+oLvdc/o4X57QvG8dgOKldnYTmu4silug5axwtPmX2eXEWisqeBpGWz3fOUNGpT3kH+mFo8vawR
	dsEPrIp4IkAax2OSfxTTXAtzr3GnLrcoiyhrcCHGvE+IWouzF6Cx8lvOqujZ1noIlLTVNt1pixP
	azIgrCUQZJf44ZnVupcgQZ2rRVJ9b0CoTEQlqmzH17wdDMWs4TZE2Jz2XeztSEIwzSMxoQOFosQ
	VP475YUdlSkSowuO8Rz9I5iCbvjB7lbekIUC8pdbqFk6sGE6+/JOq9xS3PsfBYgsVmix/Uk1Khl
	V94ShYckfQypDW5JyI68GTNBB1EGLI6KOlrLHL0VjvbIoLJvG0+IMtCSCscLkz5Zy1QChKkxE+z
	87W90vBRinoSwguDwUurxQcpztp6GhdpIFwRe5clnOvX8bQTjdT9rfAS7mrNVmQw4v+D8opd1PH
	+U3RLwDvS6aMLUtBZ/I8r
X-Received: by 2002:a17:906:f246:b0:c21:61a6:8821 with SMTP id a640c23a62f3a-c246a6cd384mr1064458066b.23.1787385923217;
        Sat, 22 Aug 2026 01:05:23 -0700 (PDT)
Received: from systembl0wer ([2a02:8308:4092:11f0::f9f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c24967459aesm190788566b.48.2026.08.22.01.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2026 01:05:23 -0700 (PDT)
Date: Sat, 22 Aug 2026 10:05:20 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, Antoniu
 Miclaus <antoniu.miclaus@analog.com>, Ramona Gradinariu
 <ramona.gradinariu@analog.com>, linux-iio@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: iio: Correct ADXL380 filter descriptions
Message-ID: <20260822100520.5b8d56fd@systembl0wer>
In-Reply-To: <20260822073653.54545-1-kmehltretter@gmail.com>
References: <20260822073653.54545-1-kmehltretter@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 22 Aug 2026 09:36:53 +0200
Karl Mehltretter <kmehltretter@gmail.com> wrote:

> The high-pass attributes were described as low-pass filters and vice
> versa. Correct all four descriptions.
> 
> Fixes: b6a097a9af00 ("docs: iio: add documentation for adxl380 driver")
> Assisted-by: Codex:gpt-5.6-sol
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> ---
>  Documentation/iio/adxl380.rst | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/iio/adxl380.rst b/Documentation/iio/adxl380.rst
> index 654d4c0e84a19..a1c249dc2e51c 100644
> --- a/Documentation/iio/adxl380.rst
> +++ b/Documentation/iio/adxl380.rst
> @@ -39,13 +39,13 @@ specific device folder path ``/sys/bus/iio/devices/iio:deviceX``.
>  +---------------------------------------------------+----------------------------------------------------------+
>  | in_accel_scale                                    | Scale for the accelerometer channels.                    |
>  +---------------------------------------------------+----------------------------------------------------------+
> -| in_accel_filter_high_pass_3db_frequency           | Low pass filter bandwidth.                               |
> +| in_accel_filter_high_pass_3db_frequency           | High pass filter bandwidth.                              |
>  +---------------------------------------------------+----------------------------------------------------------+
> -| in_accel_filter_high_pass_3db_frequency_available | Available low pass filter bandwidth configurations.      |
> +| in_accel_filter_high_pass_3db_frequency_available | Available high pass filter bandwidth configurations.     |
>  +---------------------------------------------------+----------------------------------------------------------+
> -| in_accel_filter_low_pass_3db_frequency            | High pass filter bandwidth.                              |
> +| in_accel_filter_low_pass_3db_frequency            | Low pass filter bandwidth.                               |
>  +---------------------------------------------------+----------------------------------------------------------+
> -| in_accel_filter_low_pass_3db_frequency_available  | Available high pass filter bandwidth configurations.     |
> +| in_accel_filter_low_pass_3db_frequency_available  | Available low pass filter bandwidth configurations.      |
>  +---------------------------------------------------+----------------------------------------------------------+
>  | in_accel_x_calibbias                              | Calibration offset for the X-axis accelerometer channel. |
>  +---------------------------------------------------+----------------------------------------------------------+

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

-- 
Kind regards,
Joshua Crofts
