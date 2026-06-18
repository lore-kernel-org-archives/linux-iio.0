Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887B131986C
	for <linux-iio@vger.kernel.org>; Thu, 18 Jun 2026 16:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781801544; cv=none; b=gc24KA7uYVJcn7eqWt2v11q/uZdyUlkzRUhrXAFw1c/bd3BWLJ9cP2FpABQMRrgsjURQcmzvwugsMRNSlbcoTw6wYx8IopKohQ8eS26B0LJG6Tz4QSu0bqStgptuZsCm5/yXiZSs0Z94Vg1hIwpkCntFKHas8nVrHvaJYrLqNp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781801544; c=relaxed/simple;
	bh=zNT6ttZ1svFtqKVPAFxUS49elCSgc9T9pvjpSFnQEj0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=KdHMK/MrE2rB+gTskiiOuYqiTanF6VpmJ20XBkl+qX1v/8ofrWndB1P/tkFMN1geIxWof2oqTjHeCjfhJqi17upPjyX/8VDdcS547aJDPM0mrU0cY3ar6zSBLKl9pNLwjZTYGZQ6OutTMtuds7sgGKIi0/BqMtDigOEF6I0Fi+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fslsDeW/; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fslsDeW/"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c85b73ffb52so642503a12.3
        for <linux-iio@vger.kernel.org>; Thu, 18 Jun 2026 09:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781801543; x=1782406343; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zNT6ttZ1svFtqKVPAFxUS49elCSgc9T9pvjpSFnQEj0=;
        b=fslsDeW/4Aj2pR9QAMrLi/2+8EAtw1PwsbqbECzEGXpp99770qoBeFbwE1kCWuQnSX
         +elvDWHIlHG7FiMKioYQUnh1Odb0xPikM3KB+J1ibRlXqpXXIty3/boSDtIyS90OhbZs
         neYnmb8Jwg1XZ8MWfLmCbqCQRVTU1ZKkJi69ldo/BSe87oAczp1jPa8MwtC39Hg7+WuN
         RHzhrBcJUv5SdFAgIoQ3nyeSCPrkKR77PX0vHXuhNt23xfxwl2mMIWOHQxDfwYTGF0VJ
         oNaZsVgSLUGj8qftJ1dG7LeKXAiyl0kzNYfB6QekaItI6kQfh1tKT5gUrTYUKouywLJa
         W3Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781801543; x=1782406343;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zNT6ttZ1svFtqKVPAFxUS49elCSgc9T9pvjpSFnQEj0=;
        b=S+b5vGbWcTsy6XLh7eLdJTJTrEdrUqCZyc+0rFMJqpSFl7xW61qiljBhY4HupTgw7Z
         wQkt6nbm5M9klqBIzgG+kz4goq5Z1jVo1rvOg7f0PLF7q5XcUhoUD8XUOwXS7QZb2gxg
         Up06iNwNvKV3TCeV3AayyWGRV2zo+Ui6DRPpJyRQpVkW8BjTPFCmYaD1ZHSaS+PzlYTB
         R89Wfh73JAHRxAs60Wka38icM+wSAL/3B5Z4VA2rNiAOFDZ1dEL5mi4sQImaa4lI5/J/
         I/ERGaRkPN1agNRwWaOulNgVrAHCFFUNHivHgT2zog7voeSVl8KKqgbRZ6hKOtjgLvZB
         oYJQ==
X-Forwarded-Encrypted: i=1; AFNElJ/jHIEN7JuRa9msE0fwJyUP8sDSmDFWoIMaC4dbjpBsM/2C0GVXeHSM2Lpzz/4w/U9ghHYQJZ0Zwi4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYRnW5KYV8lVyPWsx54DuCnLwL4jldYsd6EaEpbst9z7okSUF9
	513nmXSu6AB1dNNptHmwtfm2TtbMP41qPBx8kM0NtRdXJ47B03DVdpxe
X-Gm-Gg: AfdE7cljuQHM1RwJuoFdiYr2ATeOpPX1rvrr6SuqpKoQbP9e9c3pxuZVnuui+1CWvKc
	Jv1iIejR2OvC+TDV/q7+HQPGcG+ghCqDJJslk5sfS6I9X96bAv2uVs4bqe6HwAyn/VoG2NFzw5R
	uHdGccT0kZ948wzzXkFFtJgjBGTQOxMzSrwrcM0EoLffGh+7ORikM+2fbU7a/8YZ8luVaG4/HCC
	G3pauyGUGE6jO+Gmuc+3Q7i+HVJzXjOmtHJwIRp4JK4YCNiprjJkO/ZBet1hGb7SAWqIDX0AQzP
	kgXBXtdwW/NA4VHcjQpw9FHR66myqPbJGxfM3kfIJeFbispdI1yHlstQhwyR8zw0ocLEiow7xw9
	w3YgW4yw24VMW84/ZpvZwWs+6fJn6WQm/PpnSu24AcMBF4NhJyUHD46afGI7BzxAz2ZghNs0WWY
	D8HkmIXstnbdzdTWnw5vRAyWS1XZGSweXEvXV7NiDjRHWKdOCABUyPyUpmfgkQROkoaQ8Cghw8F
	IvvBPpJVw==
X-Received: by 2002:a05:6a20:12c8:b0:3a2:e0d3:37db with SMTP id adf61e73a8af0-3b9e645b96fmr6091557637.11.1781801542813;
        Thu, 18 Jun 2026 09:52:22 -0700 (PDT)
Received: from localhost ([2401:4900:8836:4853:cbbf:9355:abd1:a00b])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c88fbaff137sm3515860a12.28.2026.06.18.09.52.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jun 2026 09:52:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 18 Jun 2026 22:22:15 +0530
Message-Id: <DJCBXHCM2VTQ.1DBAHMPJHA9HP@gmail.com>
Cc: "Shuah Khan" <shuahkhan@gmail.com>, =?utf-8?q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, "Andy Shevchenko" <andy@kernel.org>, "Matti
 Vaittinen" <mazziesaccount@gmail.com>, "Petr Mladek" <pmladek@suse.com>,
 "Oleg Nesterov" <oleg@redhat.com>, "Sebastian Andrzej Siewior"
 <bigeasy@linutronix.de>,
 =?utf-8?b?VXdlIEtsZWluZS1Lw7ZuaWcgKFRoZSBDYXBhYmxlIEh1Yik=?=
 <u.kleine-koenig@baylibre.com>, "John Ogness" <john.ogness@linutronix.de>,
 "Dixit Parmar" <dixitparmar19@gmail.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: adc: ti-adc*: use dev_err_probe for probe time
 errors
From: "Prashant Rahul" <prashantrahul23@gmail.com>
To: "David Lechner" <dlechner@baylibre.com>, "Prashant Rahul"
 <prashantrahul23@gmail.com>, "Jonathan Cameron" <jic23@kernel.org>,
 <linux-iio@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260616130612.73122-1-prashantrahul23@gmail.com>
 <f3165ebd-c359-49dc-a46a-0edacedf52d7@baylibre.com>
In-Reply-To: <f3165ebd-c359-49dc-a46a-0edacedf52d7@baylibre.com>

On Tue Jun 16, 2026 at 7:33 PM IST, David Lechner wrote:
> Please make one patch per file.

will do

> Please don't add new error messages. If there is a really good
> reason to, please do that in a separate patch with a justification
> as to why it is needed.
> In this particular case, the only error is -ENOMEM, which we never
> have an error message for.

I understand. I will remove the additional logs, except the ones after
`devm_iio_triggered_buffer_setup` for -ENOMEM.
