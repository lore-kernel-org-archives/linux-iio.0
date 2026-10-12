Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6C749AA59
	for <linux-iio@vger.kernel.org>; Mon, 12 Oct 2026 14:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791816582; cv=none; b=YwM2TBaiQnKd4yE+ysP4xv35gyk/m07FsLnPmHW0yD/my0jJ2naU2IWIbiCG9YM6UWjbkLee/k3LCgw2UJR/a2AAyyGFfbC4+Qj6JbV+AgmCfoZpi7W3poHgb7lqZVFlydnBGVeledG0XWGEW+Igl4Dh6Lt4v0KyJcy74/oY6t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791816582; c=relaxed/simple;
	bh=oPkeZaNBkdRECuCTRYVoSMnv9mvchctzGqmg2kEJu8U=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LPXcfAF/zhDveQuZY18S7HRPnfQlp1erdfq0Q7ltwwY066/Lm3ByeWa5imkFdAwLc1LlxtGR8kXrndulG/Av+UrOrmUlwDfYFjTirnfKaJZPkygVsFXm6TJZWIhRwggl6NgzBsePkHtANCKrTp4XDyn1nEAi6JiNHWfYh3kiMVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k+n7mo+u; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k+n7mo+u"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-35b2c599f43so1534861eec.0
        for <linux-iio@vger.kernel.org>; Mon, 12 Oct 2026 07:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791816581; x=1792421381; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Qe8p8UxXn7BQaCP9o12LF3+dtE+HBHraOrQKjsuul2k=;
        b=k+n7mo+uNRh3FuXhOf4vDpem4wH+S9xgYaH72j3dqtr/lJptAhgz/6u1JBO3tbrs69
         Y/YU/J7wrE2Psknq2WRs+4hVprbE2Z9vX9NPWjiu80fpI1qn0EhHE6k/HyG3JuZzeXEo
         nKCHTrSCJc008qF/DzzI2x8UrXpBy7XEM+YzdNOBWNEi90cVhQySXl/kL+96D1SqjzRG
         da9AtSq2c9dDQ5gnt8tW7shSDGZNTMWFuH/AQ1aVYTY+CkEThQbTi7/iO+orFZGUy9eN
         lRfez/74vCMgIZcZO9n2E/uC1mrXwT+haRzc0EOK7pmjnpkWELG8fimzexdpl7YTu033
         AU0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791816581; x=1792421381;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Qe8p8UxXn7BQaCP9o12LF3+dtE+HBHraOrQKjsuul2k=;
        b=u3Now81W31IOeyQi9xv1frmx0D7cxZRRC//1TeJaj1ZmBkV+ikM7+U+2vyqmsfXjrt
         v2siZa+hZ6qhoigY8QgX+mWO4IYpbmgSWvKPpSY8lo50Ujlp9IlxDcC3OG9cf0QKSeM+
         PbyF+RNAIY8Hh+/kETVvRcRabNQjX7t7ZyOyZYnCEwZbYKGItdAOUibE4WO16c0Plgx1
         GWe3GDfq7BK78K+eI9hW7hO5gGHz7/i82weXCRDzO/s5wdkstZX2fNfVVtWbQ0DFU/oL
         g9OU4XC/B+96sC7yqMg5kA7LEG5RtPLHww6dV2W5J+fv+av8Y+Pmqqc54ym1woX0Y76w
         o6cQ==
X-Forwarded-Encrypted: i=1; AKwUvBz2EWOQIzALFLUqo0q6OLDVklOB65ucYZZnVzvxwH4v3h9Fxog1TUcQ9FZbnOO0QKOB5zdriZ3pzuM=@vger.kernel.org
X-Gm-Message-State: AFq9FYInqxP+9h/WH1avPZjuFkomKs+I4BRA27i6LVOqwYe5BqKlzXqC
	5SXt9tbNywyVWEjnUj2hdrFRhb7sW5EI7XqwGpsWHHSkdqnHqBLoXE+y
X-Gm-Gg: AYBFou2poUFH01g2kdF+XzY4OuLjAktogGU7mbzyj9SYP/M2hdtIlH679+RrBbG8Z7U
	B5CUl2GXU6dfbUpxUwjuPUV39fqdwGQgTbGmUhrrPYLzgds31CReTwFEfmIEKRVxoBgHNXJFjbJ
	B3lbM8hyQ5Kj6Mjz+biGhRxnwsc3jLIsSU5SP9jhXYQXc6MZDAuFhqfj24PWMogsc5MiTVUQMHA
	3IbQbBjZeirwJvyUlzHmvQLClcq9avEcglc8KH0QZ87J/yih9Tyl7C2QAWNLs+j8thI90QDAmi0
	mweR9rHFuW/CBE5t8yaEGP0gi0M/bf1sCC42Ht71dkWbyw5jzV/kUvWqwK5UK+ciZVR1kJp5mf7
	gDC73D4jJ+F/Z5aC5TgErHRUxk2ZYqqPyhKh47UgXJBYmJdfE9VeLRmoidDf+EOimX+ioOowETr
	0dEP4k+EUedFtR8k/+KHXngABIIPpogNgOeZv+15IDRDK4tRRdy+Wn8QG5KBr8Q6QrHpQzDYlRJ
	q5KETPWK/ut6QxstOC0DUu4jM95NEygkzI1AY1kkB7AkzWWAaHGnA+H00GF0/ZjOdL42j9G87g=
X-Received: by 2002:a05:7300:8806:b0:34e:9147:b862 with SMTP id 5a478bee46e88-3537e073ab1mr17729284eec.34.1791816579688;
        Mon, 12 Oct 2026 07:49:39 -0700 (PDT)
Received: from RDEALENC-L01.ad.analog.com (162.10.253.157.netskope-rdns.com. [162.10.253.157])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537ca6d202sm33239386eec.13.2026.10.12.07.49.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 07:49:38 -0700 (PDT)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Date: Mon, 12 Oct 2026 11:49:30 -0300
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH RFC 3/3] iio: core: use kstrtodec64() to parse
 fixed-point values
Message-ID: <s2h7eparj3igtairdv24jxxfqrrcntwsgq63de5zssvylxcj7q@lgr45mi3ebt2>
References: <20261001-e-notation-v1-0-75187bf06c10@analog.com>
 <20261001-e-notation-v1-3-75187bf06c10@analog.com>
 <ar9kuHwnTM8jdkqR@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ar9kuHwnTM8jdkqR@ashevche-desk.local>

On 02/10/26 11:00, Andy Shevchenko wrote:
> On Thu, Oct 01, 2026 at 12:34:58PM -0300, Rodrigo Alencar via B4 Relay wrote:
> 
> ...
> 
> > +	/* fract_mult = 10^n, so ffs(10^n) = ffs(2^n * 5^n) = n + 1 */
> > +	unsigned int scale = ffs(fract_mult);
> 
> Hmm... It's not obvious. Maybe you want to use int_log() instead?

hence the comment. intlog10() from int_log.h returns log10(x) * 2^24.
It could be used with a correction:

	DIV_ROUND_CLOSEST(intlog10(x), 1 << 24)

because the header warns the result "might be not exactly n·2²⁴".
Assuming that the fract_mult is a power of 10, ffs is the most straight
forward way of doing this.

-- 
Kind regards,

Rodrigo Alencar
