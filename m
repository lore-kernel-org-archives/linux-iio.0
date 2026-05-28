Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9732233923
	for <linux-iio@vger.kernel.org>; Thu, 28 May 2026 07:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779952249; cv=pass; b=L5Vk93cHTADKDgu8r1XIn6brTc0L1MHFKekl4jeZq4xCt5i4l1ig7aeODaJfHVGZGdGu5uIy3k/qs2vAd3Eo7ueyxWCKLbBacTe9s20pR3p8uDRDULfkzXpdOekE0Rt+ssM3XNxNzmnnNgY+Ll13JE8Vg5UdBlyTrlLAqgWRzCU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779952249; c=relaxed/simple;
	bh=C8247qS6SnU2nr9CzMOa8FmWj7C2y0Lvb8s8J4jogRg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cLUO2ACJ3hq0OlYFM+jGZoCqKbMFDEHio+g/zhFGXrNcdrVwMvqN0+KpNzPrr3KCugHEY8KNNIKKQGp73N7Dnk5URLF+sdIpklo+F3LdGy6Y3VShkUhGGwgT/tcjMsrEZe/WmyO1wFIoX1LVq7BYwYEcvd4TCpKv0jAcDKAVm4M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FQCD+a8u; arc=pass smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FQCD+a8u"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4891e5b9c1fso107347235e9.2
        for <linux-iio@vger.kernel.org>; Thu, 28 May 2026 00:10:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779952246; cv=none;
        d=google.com; s=arc-20240605;
        b=FTebbOXIKEY8zqxKxma9ETZ1mtMNMqECSMsWHR+05wMlU/TrQtiu4hDWm9zmsIvhpJ
         ByFfNuSr0z//TVYiWABlTWeK+8pp2owo7vWMh0fo0nnhnoXatQJCkf3M206G7x0+9gHD
         0H0VbL7Sn9qZ2j2z/FkJe3rKYrDPGDvpG3DKK30fCKHIO/IA4KRUAuZGtf3QHLQPyPdd
         blKDaZKRyUaOmoy39mlqgPa8KZ4s/gbVkWjB4PuEyxJEe5itme1nzAjb7POoxnEtCGC5
         v1xDNmDCHiozdKlUT0otZC+c9uZWV7TnatAj5Wh0lWLS/gF9sCoqZtsZD5jr/FK91coW
         5DZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=VavC2fTy1inz/S4sNaYxYFEFCBdG9pidtnyJNQj99e4=;
        fh=tzCMlpyKfnEi8hQSYr9iaWBpOchsFelRIXktHfTlLcg=;
        b=NC1ZYBmf1kcpWyGWTyDUUMEzya370ZinSSNrK9IVzjd/VcFhAHt4tfQiaLMqZWl/t8
         mBwpEtpPt17H9RUtm1yNpCXa4IeI98wnmmmCnvCRCvMjBfxLSpFXESzlpA1ZhlueE0oJ
         UKoNzu7ZF9+PliI1c7BYY9sxNvEVbppfEnGjMTvS3llip8EWRJxzl+/9gJQopl4tgdR0
         dOgloneIF/q4sPryQ8f33NNroYKhm9LSdr/XfRApfXOANFRj5DZ3Mt+pPNLP+pmOkjxE
         aygnsX6nq6CoSJtYcpKAQQzIKIH5YMaryZsMdx8ddTxOYhAx+CeB9bhhxL3c96RU53vy
         GL7w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779952246; x=1780557046; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VavC2fTy1inz/S4sNaYxYFEFCBdG9pidtnyJNQj99e4=;
        b=FQCD+a8ueKMclmrz+S8NfH0WeJLD2kxTcRtisCYcQfSMtkyr7Zz2Td1jGYbNvidtQ+
         IkkcXWd5r2Si/kI1Ou1FAx3BdRkwFMtLnQpUdsydQPLp4DFZ5putHwmBNPgRpHmGR5NO
         6B3H7/SMOfyoqYYKlBgzWPcPd39o1q2EiSrRM/gg7Qp6OQ2Ck3TDYAz70nKHJYX4sQKS
         O1FA/aosuXdz0c96mKYYvRRM1x+4JmjCrCJnVF2t7/nO9V6COPHAPL+LtSNQNCUXvMWZ
         BfvIcv9rMSP5ecghTdSFy1t5Mrklq0XN7oE90ExpIE2i0VZjZOatfE9nvRptgAv7HXle
         IyfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779952246; x=1780557046;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VavC2fTy1inz/S4sNaYxYFEFCBdG9pidtnyJNQj99e4=;
        b=ge3fxcB9j1dNdidoXNF0ekzHHSvlo59GkpMCO8eN/+cRhAezAKz/ndAojgUFSnCK2k
         DX2eEa/sf/fEV7C7z3J0OZTIqVL0vQgcGY2AMVvF9Go0GwWhyhnRDZaFGbRnEMxWifRc
         85oLLovgkU/U7wqfKSqayZEZl8iFf5pqKgIte/PwBy2eM9SHf6AZvtFvMJoHHBh8GCWf
         oQ/yBfB8G4xktAx3hWCt8iFlhtUeIT0exhepDMzpZUdtZlqlJrYSnDJhwFpWCoE84qlE
         34Cwuimz23ku3+PieWaDloxCoJV4SzQUfL7U+K/6noje4IOwC9wPGEMezbwnpwWsfwWV
         LYUA==
X-Forwarded-Encrypted: i=1; AFNElJ9o+5q/Kg6w7h65NzgVQlfN86WK3mgPoGvAfV0YWd1MYeGB1u2S4hmWWIO9RRjh6SA8c/7PzKgbeVU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoFJUE3t8G9fEHwKM0mnRQk5KUwV22DEvYFwpga0i54IcZYeVp
	yAyyBpc07F5d9wTy452pWYC2wQ5JuBQmNCcKR2LQsLhpvE0hYbeN9G0OKDKfaUNqvHr1tFbVsd/
	e+et7lCq7DS9ZCSRkz1KvhJvgfJnf6p0=
X-Gm-Gg: Acq92OFJTsyp18YNaPBsxe4sqOHin5A0U1S1QCCXq4CzYeF7CHWPDcyVX2hnFh7mNah
	9+2UtYgldtuhknAaqtvFIU3clGp/AGSboC3HXiKu4kmZFg05AgOdxXp+ombbAP+uI3U+EgXyVSb
	kcl0rm2FDWFoqOBrMavoMmHkjRRuXJMGOFayS5bODgVcxRphOBf9HXnch/ViK3SewWzZtNZ7F3U
	HcDAWU9x43/AJ4Y5PZBS9m7zAqe6yFxApnDTM60gdsLt6jftRnrS9oGAo0PuREbgswjU2E91Lpn
	qbBf340VNfl/e0sGrIb+tk1PegZP7B4fochhmFViYLNShxlLMFOW7X9V0VD8QXORFRkWDJkBKaf
	3oJzRS8YPCpuZME3eaMmPvUHkzT8Z0FfWFIjwJAQ834cXSsQu7+O7ETehq43AVbedhA3TGRaS7g
	qhLu1KBTE1XfaSQWpP
X-Received: by 2002:a05:600c:3b02:b0:48a:581c:ead with SMTP id
 5b1f17b1804b1-490425ac8a1mr437717175e9.10.1779952246165; Thu, 28 May 2026
 00:10:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260525-opt3001-cleanup-v4-0-65b36a174f78@gmail.com>
 <20260525-opt3001-cleanup-v4-3-65b36a174f78@gmail.com> <20260527193019.367da1db@jic23-huawei>
In-Reply-To: <20260527193019.367da1db@jic23-huawei>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Thu, 28 May 2026 09:10:33 +0200
X-Gm-Features: AVHnY4Ic99Oi2ZPDVbrNKpW0pGpiYp8QMyFxlsGaVy_U8pfoogkSuCbzz5Kpnl8
Message-ID: <CALoEA-zvOAEGydkhGR1bT6w8ouT4GDUacthYUd+CSvoP_X+Syg@mail.gmail.com>
Subject: Re: [PATCH v4 3/8] iio: light: opt3001: ensure correct parenthesis alignment
To: Jonathan Cameron <jic23@kernel.org>
Cc: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Maxwell Doose <m32285159@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 27 May 2026 at 20:30, Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Mon, 25 May 2026 10:20:17 +0200
> Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org> wrote:
>
> > From: Joshua Crofts <joshua.crofts1@gmail.com>
> >
> > Ensure correct parenthesis alignment per checkpatch.pl report.
> >
> > No functional change.
> >
> > Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Reviewed-by: Maxwell Doose <m32285159@gmail.com>
> > Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
> I was optimistic we could get the fix in via one tree and the rest via
> another but nope - this changes alignment of stuff to close to that fix.
>
> Ah well. This will have to wait for that fix to make it into an upstream
> release. I might do a pull request for fixes sometime later this week to
> get that going.

Fine by me. I'll send a v5 to remove the dead code identified by Sashiko,
unless you're willing to remember to fix it up after the fix is upstream :)

Thanks

-- 
Kind regards

CJD
