Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BDA337E2E0
	for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 15:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778599536; cv=pass; b=HWIWXJABaZak37otUEXY5T53vT/6K8wh1TSGE+ZS49fawL9btyMgkIgo2lKwVDh6zqZTESYXZxdlE1ohx5i5zkEyZl+pJslfOn2iF+//clFjHojQ3MuCctndnXZ/iCqu7WMZGjoKxrk27H0N2ZedwIQYr4uhRBNkPDrtDT/j3Ls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778599536; c=relaxed/simple;
	bh=RN0oi1OCydLHZNYjP3k8xWSXRUQOZgpfvAXEWO/zPAA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YkyGvGcSpPbIxav8fo0WmzIxvKiz7hGiJcHTyyY0ErDlCwUhjsLCrlmlJLi5e4CjGlcGfpQT7fyCR3ERmSFzokAcr7n3x7HWPpbzS796w9y64HyQaA13sL8hoT3TMKRkmHjVVoNxpMd9XF7WRiIhKR+aJBRGqVczKDShnc7zCXk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DXYIHWnC; arc=pass smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DXYIHWnC"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-38e84ed22bdso52232771fa.2
        for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 08:25:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778599534; cv=none;
        d=google.com; s=arc-20240605;
        b=X7NRWuRondja9ZiPTkbigAz9TWytNjgBC6o2J5V5ZFc1wIWzo9uF+YPjBy6Qp6kzZi
         bebTDAVkCMUW2HBsLB30THmHabjZf9wYBZ/uzXAn0ExaABQQrU/HdcgdNdBj3XdqPJDJ
         AdZqiScJblnxJeDBLoNv8ewY9BcUwUeLg+Sux0tU4mrtexmUrHK9Y0fWMN6ik0uszRQV
         c2YBEsIg4usuR7EWJFsvVZx5U2TFY7jaVW9WexbgndV0+SvBiwYhQO3dy57vElamckG2
         LhIyYtc5BT5ARskwlEKSFBTj5LEQhEWv4oZ6nxY1Wtu5w4z2JrIp6wi2jTFoKtJsmlCR
         0yzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RN0oi1OCydLHZNYjP3k8xWSXRUQOZgpfvAXEWO/zPAA=;
        fh=t3BWYHkAgIGuVUfASEbkhkjBurvHQcMOoea3FZdzCOs=;
        b=c4xFfBURE8bPygTIlnIrVtrD1UuiJWGdaalApeZHyzmeWMhJvAt2Tc+scZMQWs8eLv
         VZW3uD27Rz6ITHBe16ZYlCCoBf4R41hOO1Oqxwzp4AsyH+IwgDbyKYgUWs88memJP0Kd
         unEe9IA9Jaw41RM7lG/ZXBXFSzVi4T3zRJqfra82t+j5wVqfRL6OrP0wq5rFt6ReSfum
         J0r/sTgSuW1eL8O8kv9pfy6iA9eZYTRlhV/5z46RXZCtwzrHCOIKhq6CfiC+1aRoGPv2
         zjJ76Q8g2387Ar4LFqwsvcqaMAmAdBYQWZBYDuWF7hEKUKVtrwy2UEtgNTBwVgne7+lE
         zPnA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778599534; x=1779204334; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RN0oi1OCydLHZNYjP3k8xWSXRUQOZgpfvAXEWO/zPAA=;
        b=DXYIHWnCKWMYgpYaqaiaU0FTe1nvZffO/sxyIpSfzOdrgRH/vipGStV3kOEyiEQemr
         12wzpKz2fnwmGTCIAAsgLUd9h6otPmjzg4WH7bRUHa7XwvvFCwyX/r13MZvdnLl25AsI
         UYTLbAA9ywRVsGNupXcYvK1pt1nLxUVrr07dWO18Lgq/nsg/eFct9XuRXqzLwUPP4II6
         fzdaRhdR3hP13d9Cnq8DQOVdjntwrhbdH8uoOnVdf0ZBsiG8dFF7IFsLv+nMmWzJSavp
         1ugfyCk1+MFsAd8FIXbX1YulOwaxvfIGHPsu0jCmZbtwyV5HTGTNwPDknE/ID5J1au3c
         PuSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778599534; x=1779204334;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RN0oi1OCydLHZNYjP3k8xWSXRUQOZgpfvAXEWO/zPAA=;
        b=O7N6UiK8T9OHL8yfDI39Pa5B0qGIsprHZNkp2mML/4MnLY4rECMs0hETB2dJqWTm6L
         wVj/epEAyT4gUtV9MFq1dEOYwpy3YaF+q53RKzXslnbWSxx8nwucOK7XnxnX/yznhViP
         0xx2i6FN4w88qRynXKMmZK+zwF1eGptjdyVJJ6LIm1CroIkoYwi4T32gFGVrKqK5ieFs
         rGPqC+56EEADmM8XeAIdpLulN27+Q4M/oUJaCnag+BufIg0C4nFenYNaQ21cYROHSGud
         2CTuyH4rzdIrf29fLpXpDxJiaDfVjT20ZcunwDGjZUuuB4B2KMnqMlOrTARkeZFmgJvc
         QOVw==
X-Forwarded-Encrypted: i=1; AFNElJ+2lyJWlepVtAOKemR5krseyfIVOItwyN64XZ7agnixXUPW9rJAIoQwaD7ovmoi2FmAQ3k/q3YnWRk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/bXWAu/Z0EeoFqKxzdwyDpTajakvOkeVIlEJK/uMgRA6lLt35
	SbM9cocBmMuFWQ/2Vw5xuzUz+2WcaOCZG0tWTT7b6pNlfIFeuNE06zRSglyEKJt+XujbHRWVeiZ
	WhApE5UIWCtXbZRk2n+PbeCW+UB6bF6M=
X-Gm-Gg: Acq92OF5Oj0z8FBxPwVXUPVPmSVLqXONpN1oIrrwEH+CFBSEFU2VyNSt9XdUOcKshi4
	ODRrvnzXZwKgrzhpxStBBjr1XSlUUh35tdD9THDhRz8+1PvYCSZu7di8Nu0sgGFu3omcOdJYBUP
	fntMdhJQ4xijl6Z/LTTfShSeWRi9zS1AneOPA8TzW/e7PbojmiGww1ZUjfnpI5UH1xmP4YczU1p
	AaZqlPjQb4zavOiht1tUC5mbRAENVCb0inFx+EI4614sDwXvzkdqqOjnXv6ZFHLuH23n7uLQNIP
	Cx8a/9k0QFLSGycyy4FY8OL17p+e0iUL5a2mXhDa0tqJn/krtGjh5Kc1gxIgcpKd2Xg0d2u53FS
	osJjubIj7feSToLjPRQ==
X-Received: by 2002:a05:6512:114f:b0:5a3:6731:910a with SMTP id
 2adb3069b0e04-5a8b6ca1d53mr4742597e87.11.1778599533136; Tue, 12 May 2026
 08:25:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512120356.40839-1-m32285159@gmail.com> <DIGSQPV2STJK.2S7C67L7I0RTJ@gmail.com>
In-Reply-To: <DIGSQPV2STJK.2S7C67L7I0RTJ@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 12 May 2026 18:24:56 +0300
X-Gm-Features: AVHnY4KCDZ9jmfYdPkVocKjJxQXb_MTsVFGLStnqvx5mp3eWZKeb8ubnun0NPVI
Message-ID: <CAHp75VdxUR0jdW2-k5SVGC22OK07VxHK2ORtVdSdniPWdcniPA@mail.gmail.com>
Subject: Re: [PATCH] iio: imu: kmx61: Fix TOCTOU race condition
To: Maxwell Doose <m32285159@gmail.com>
Cc: jic23@kernel.org, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Daniel Baluta <daniel.baluta@intel.com>, 
	"open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 12, 2026 at 6:17=E2=80=AFPM Maxwell Doose <m32285159@gmail.com>=
 wrote:
>
> On Tue May 12, 2026 at 7:03 AM CDT, Maxwell Doose wrote:
> > A Time-of-check to Time-of-use race condition is present in
> > kmx61_write_event_config(). Move the mutex_lock() call above it to fix
> > it.

I think you want to elaborate a bit more on this. Id est explain why
ev_enable_state needs to be protected. Not everybody is willing to go
to some site to read some AI reports and interpreted them.


> Reported-by: sashiko <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/patchset/20260507223337.48437-1-m32285159%4=
0gmail.com


--=20
With Best Regards,
Andy Shevchenko
