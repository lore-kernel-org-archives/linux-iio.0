Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE3023EA85
	for <linux-iio@vger.kernel.org>; Mon,  9 Mar 2026 04:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773029690; cv=none; b=d5KKoYd/jXNSpsxwRnhbYHswdF8Xxqk7fHZ8aXHWSzUazoaZ11USt7wXv5jb3IQ0qY6J3EOtawFfjKID2JBSIUGqRqCmWaca2I2LKwruhi6hbgiiO1fgXJAlDP4f0MhaIJG2tuZs1HWY9nm+LPJUUZzj+fAYBPbcsSxBDlol7Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773029690; c=relaxed/simple;
	bh=U6asc4CK5rfMScaa1F3F1IM67/4xBwWnj7bmkmyyTxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A6mQREnVEhm+5EffoKxHmbh4hKKu1sNMMZlIVeeMcNF0GX9JLG3/72hd9++nqj0ccWN2EWlNNEv+8uEoLV69gau8EuOGFuar4z8JBwpW9sIEVDbq6kOibv+ZQ6I9grxhua5ksNRsxAuXVLDDb8EgqTloIbKlNV71RLO47nlCSvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kuCiXgNL; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kuCiXgNL"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8296dabef74so4962626b3a.1
        for <linux-iio@vger.kernel.org>; Sun, 08 Mar 2026 21:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773029689; x=1773634489; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U6asc4CK5rfMScaa1F3F1IM67/4xBwWnj7bmkmyyTxQ=;
        b=kuCiXgNLy01VSkvKAUrqjX+4kqHFNVETTI2SXFd8nf6JcItTcmbUvUqEBzFOazafVC
         SAts2NOwc9Z9DVapCsvv/ymJo6sbdpZKI50/8DvZKmsjwXFu+/W4hpaq/cHT5YFoLhR/
         sZ79Af1T2klXmgeJ1Z8KYgcCl6w1XDP/DWOsbWlQFnqLUpbCj3RW45CWaAz/AF3gNcFL
         /uS5manOfSInBQ2uYK3UrDjX9OagfnRICtms3jhyvIKsFv8Do0RL07OKwXVgwIaKL3ce
         fX8F1b9z3YPHqtf/ak+4GypMZ6Xi6dbtMEG+0lljqeEeJYpn38X/PTbNNG+kpvaX3XUf
         HMlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773029689; x=1773634489;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U6asc4CK5rfMScaa1F3F1IM67/4xBwWnj7bmkmyyTxQ=;
        b=wPhpFd1urOXe6wGI/YnpxTHGYgbowfp6PAxAC79byLWKtslGEm+x6J7kLaEMDV4t+Q
         sIaY8O0UBwjk58Mjsd9QFYu0d1c31UVlbEFYPxcHdcAK7f2XlLBaQ/yvfRPNy4uuiECp
         MutunKgCodVJgAfuvZX8JoY6QfD/j99RaXJlQwiKt7+F6hGRlUZd2aZuvur/xnzvYbJr
         3ZrNF4EBFRPCR6ghaPzszXGUWjUlNIsPYxBs7/cSX4jJT8R1SSY8ybJ5WM7JaMcqzK8Y
         Bjnbs5SUeCDh6WN0ZiRxtiZsMx8rko8kyd+83YMnVUZLhdZzlV8r54lPkFWBHBV1kQM6
         ThdA==
X-Forwarded-Encrypted: i=1; AJvYcCVMXy1NwnKgcoqd8BmaCU9OC6HTABYArO6jHRMsRX7MJUNNdihyJQrVgalBBGmn9iXHELmhJtO1KsM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyepvecbd3oJXHv+qblwxsvapueELemH2gbyVdOeGAZ3WEFRYcG
	kBI2WCIvwy2thn6RMfItSFimAGc2fgsj6knZn+0wKPBk/G6D9HttEbyD
X-Gm-Gg: ATEYQzzDuje8efJfeXphP8munQ03QywMp11H/I+y3Y1cBSNCw4NUBoGNBy75RX9T1mz
	1qRgfAuqctZD7bPwHUccaU7dPAHX+ob20tZDqkf0Ejkri1w643e1xwaJW1qeHh3+vuFzOiNEEtL
	28pq6xmHVWiq1HD62TJXxu/AQ1ZstFGu2dhd+WKbLJq3YxrXYjm9W33iPBSVf39xVVCCBjd+cRX
	34VTmDrg8uJt5eyh5j5k5LZukcnYehDZ6g78kCniIO7kIx9FTA/sQ7Kv9YpTKO0t92xJPEyiqLI
	zeB2/u9NUEUWcIyZNV+NadYnpAIdCFspjbSPy14ObskfGbG18T/KfVNypQeJMpob8CPCbHWsxZM
	vQm5wZttT6+zXFCbV/rVnG5UUUN9BSp6BpUehWU5N+mjr7u6SJqGDgivJR2NkNczwRLv9yTMfg+
	5u5eFJhHwqp0a3az4Yw8R8
X-Received: by 2002:a05:6a00:4b11:b0:829:9c5d:4342 with SMTP id d2e1a72fcca58-829a2f397d1mr8997383b3a.54.1773029689052;
        Sun, 08 Mar 2026 21:14:49 -0700 (PDT)
Received: from fedora ([110.224.250.98])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829a465b6f7sm10191748b3a.23.2026.03.08.21.14.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Mar 2026 21:14:48 -0700 (PDT)
Date: Mon, 9 Mar 2026 09:44:37 +0530
From: ShiHao <i.shihao.999@gmail.com>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: marcelo.schmitt@analog.com, jic23@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, mazziesaccount@gmail.com,
	linux-iio@vger.kernel.org, i.shihao.999@gmail.com
Subject: Re: Request for guidence
Message-ID: <aa5JLY7UWrG7-9EN@fedora>
References: <aapjuiq0JSVWfmWA@fedora>
 <aaycGSJIQicH34jD@debian-BULLSEYE-live-builder-AMD64>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aaycGSJIQicH34jD@debian-BULLSEYE-live-builder-AMD64>

On Sat, Mar 07, 2026 at 06:43:53PM -0300, Marcelo Schmitt wrote:

> Glad to know about your interest in the IIO driver GSoC project.
> There will be no IIO driver GSoC project this year. I suggest the Device Tree
> Bindings project as an alternative.

> If you're anyway interested in contributing to IIO, there are links to
> IIO-related material in the non-active IIO project page
> I am unable to send any hardware anywhere, though.
>
> With best regards,
> Marcelo


hello, Marcelo Schmitt

Thank you for your kind response . I will surely checkout if there is
any sensor that requires driver because anyway i will make one driver
and i thought it would be good if i could up-stream it but for now i am
preparing for device tree project idea from Linux foundation because it
aligns with my driver development goals therefore if there is any
suggestions or any help i would appreciate it deeply. Thank you all
for you time.

 Sincerely
 shi Hao
