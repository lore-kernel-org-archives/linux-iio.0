Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3638B3C1969
	for <linux-iio@vger.kernel.org>; Wed, 22 Apr 2026 09:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776849560; cv=pass; b=SFaK7HHURPJC//CrikfqTnz7P3L5OXq45ovpe0jwWE+faFfmWbLB89fhy22W7tlM1dSYZ+loicNrWxVNvWC+8ZgBzUEkSZ2lacP9HJCgEovr70w2utH6WqzjP8EsqzI+zgabdQEauoVOtJKWSjkhuyrQNgUOrNHVoVqcqa4hIaw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776849560; c=relaxed/simple;
	bh=6oVJ4E8IfXqQu/FZrFLDzafdCjiUSaWeEJXNQcVSLYM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QE3YBUmv+XegJnjxvFTgNiTZzNWnuhs92uUrEWTCAHwAKyXwJsdb6Rg7MOf/gUxRTYDcurQjzWje30AEIpEaxbWvEv3GL0cXx/JO92qyOCR0Fl1bCseAAL5KWWUaHVSHsjrTlzmw4aiQAPskQYw5ti/0WdeUamWQ6M1LjayXr4Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YQOIsM0i; arc=pass smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YQOIsM0i"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-43d7badbd7dso2519553f8f.2
        for <linux-iio@vger.kernel.org>; Wed, 22 Apr 2026 02:19:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776849558; cv=none;
        d=google.com; s=arc-20240605;
        b=loyhvTgQCDQV4uk//DQiyd3DAeaBfOT1uTznlwSsWvmKDYhh/riMyvtXu4684KB92Q
         wkhvj7gDE7Yclve5+zOqtGcCLpI8w9ycwe2OvUVLOgoNj5F/ocLmcwKaS03b6/7AlnL3
         xyhxuMOoTdLvKAoobR6JxoweZ/kZMH3ErcU2il3jHMAe/tLqkH7+rWM3Cvb3xdfpjjy9
         Ymg15T5G2yUJsqxhFaWirufkGxJ3CCBLdIwQs/VLcpajsEPLmE5aSVk0TdYUAxcqyPEq
         BaSxs1is0h4l5zCy9ide7/5hZ3Ee2duQOvl2UCejJoJik4FQEcVuQliWDDEB3bHzjPJq
         rLGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=q1VOIAexwG20ar860e2WfnSgDXiW2Ww41NuG8ToL39A=;
        fh=L2RxtRD5d175hDdSnaTCDU1hpf/WgwwNHu5WRGlqo24=;
        b=Z5E1FHUpxko4C0/yt9WnXH3TEksJESW8x0vNg7kAEb5hH+k1QBnX6Z3Y7xCQpytQeg
         5zlYF45EQWE0izDaCiJJCNwPeo5qdsyF2b8H+iqwDcqr0ambqG2SnGctJ3SvqtKIXB0S
         CAV7PA3+lb+6dcsnt5FyHmsytupIXsWbUTO3mwzPbFglZbAN09YTVYwYiniD/GSOnxda
         FXWT14Rs3qbHWHdvJwKt1BzLIIPqaoqjeNSGwY/hSqc8R4ZSjAXvZ9RS18juBD3qxluX
         klU8NHYOsIvIBqKk0tKWQXhfnlOTzcloiC//3zmQnCqjvFodBxUL9l6QtfkWOyK+rQpa
         HOmg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776849558; x=1777454358; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=q1VOIAexwG20ar860e2WfnSgDXiW2Ww41NuG8ToL39A=;
        b=YQOIsM0iNLSGwn0jOc12IjHrHAEDqRy2f+mPzeHZkQAkkTrO4YWwZEeQQgKqTrRolD
         2aqNxHxQSI9BRXwKoFbldoWPSrk05Uyq/4vADiji7Gzt6QVdjmu1bo4M9YSViojiFaCg
         eIe56aq68f4jbuPujupJmGIikrK02LvUIaSINUShEbIgdt/SYmFLWyJvuWtmkP3IJcVJ
         c0Yomi2ao3yF2qVcULyLo94nO1PvvEDJ6lw7yN7E1ABECqn8303YLXgiCWMpmrZo122W
         OnRfB6FcJR+Jpnpz/9MjJZTpSA6Zvt5gyZbNmgFxsEOFl8GZ3EZZj9sSSlPCm6X/3zLk
         LUFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776849558; x=1777454358;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q1VOIAexwG20ar860e2WfnSgDXiW2Ww41NuG8ToL39A=;
        b=CnHtGyHen6bmBIyDsEwLcbDoeqxdhE0CuevRbYutWn47Hna9+5INmfmI2v/qZyt5pV
         SChzKyaoguheC1YY0brn+r6moSmrXbhlPymEKa+J4S1uX7ruNIXMqbzIRb1SKvjtUwy2
         eGEd1j+Bl0om2lxlCnxcxia5Zv0GkzwkwDITef/fI/bqMeqIkhGKKKX86yZmf8DzSm56
         ICgJE1+OpNs4KXwOgm5H65CEZi6rN0M5epK7SlQaVIRbKXJeIO8LMdUh9c6WPUAVCn7i
         ZNEIg8kKXGvGjPGLKS7rhWsjBDk2gMH39+VjL0owx77HLFyTkuZYP3QBMvby5tPpfSXt
         DkaA==
X-Forwarded-Encrypted: i=1; AFNElJ+W6FF6g/irAt7H0/Y/ybzFIqBrgzXM8cmFUsDHALEzI70CQiDiDK7IEffd2/i2x9deQ9tFnklmiZ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZGGe3gY7QPxBU8wcx4fK4PHe233bopX8wMNLT2/zNCbrhAV4m
	MTkTEs2ptfqibaJUiTvF5KRBE7BxPN9UjD7eyE3sHj8bLjJXk9stpSsqTS4k46wxasuvNMxIHVx
	NB7yyXhzA92iqaPunvfXxfZm4IC6WGiI=
X-Gm-Gg: AeBDieuQ/9i+AUqGNuSAB2C15UeLs/PnwUrMANedU5JZvtDp6MHikcNrCBgHZp6WVAI
	BXK+QIqsGMyCHkrzUa6Xojc3Y2HN7hC6OiKBZuhFLEqBNKT/eMWrQhdJpmcBUCYPnxczr2Q4Ryt
	P2vKzoNZ2+w+6iQvJDlXBpBAlKJKgTMYsPW8lrbkv5mQeKLXvEWISjYNnxu8gQcCdzgghQtVD6F
	rHnNv+f1cU9j3Qy42rLe9dRNkGQ7xX7KXnYeE5dcp44ssg9uW2nERCGLXyUaw+Ie74c5PSmzMLl
	TSdIS25+Q429EZv3MSd5JqOBkXTTVOxTk4Pbb36XipVHVcWVgwIC4pdPkn1C1EbwVEtazEJint9
	9M1bqMVHLF9wjPm/yFnA5a2t6pTEU5m+L+mejfP517ZNu0cCIvDv0VkTlfFveqqNqIvsoapsOGA
	EFRmR2KopfvJ9F3Xhq
X-Received: by 2002:a5d:64e3:0:b0:439:bcc2:bf0a with SMTP id
 ffacd0b85a97d-43fe3dfd560mr33209819f8f.23.1776849557398; Wed, 22 Apr 2026
 02:19:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260421100722.1296-1-joshua.crofts1@gmail.com>
 <20260421100722.1296-4-joshua.crofts1@gmail.com> <aeiMPrBs4BJE0H_k@ashevche-desk.local>
In-Reply-To: <aeiMPrBs4BJE0H_k@ashevche-desk.local>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Wed, 22 Apr 2026 11:19:06 +0200
X-Gm-Features: AQROBzARdps2gHNhQV2t-Z1O2aW0Y_nNRJxhJwOkA56DqA_dR1hr2qhwolswuGI
Message-ID: <CALoEA-w7T-15paJ2j2kGyaWjeK9FpHynS+vD0rpv1dBKEo3gcg@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] iio: magnetometer: ak8975: change 'u8*' to 'u8 *'
 in cast
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 22 Apr 2026 at 10:52, Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
> "While at it, fix the indentation of the parameters in ...func...() call."

Indentation is fine, but the email client clipped it.
https://lore.kernel.org/linux-iio/20260421100722.1296-4-joshua.crofts1@gmail.com/

-- 
Kind regards

CJD
