Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B43C3A6EE3
	for <linux-iio@vger.kernel.org>; Tue, 28 Apr 2026 09:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777368982; cv=none; b=s8bIo27TblXlTlJbxp8LsGRH9TginvZ7vkNC8JXfnmSzoTMn5ZeKRxxgntjzuXHpFwkulXf1m/WYeRM3HWQ9n6cz/AZ5mLvCHCNZzgXX7Rxb5uN9r79ojr6riIAO0hY2a32XQALFO3Gi/HYytPD+zSZeYgV3rtGMexKrl18Xb54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777368982; c=relaxed/simple;
	bh=8DPrOqm/MQALU2UOUDeOQ9su/H/BzZxxlv0DQu2wyKs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LjMTDaGo4nnkd799dhh7f+4sexi67wYCiuoeVuX9RLvBXPfu7B50qPRGlolr5Mrq+1aenIMOLnRifYzNT6b9HSiTq0cCGI+7Efv+Z2bunjt8Wr8d+7JGhw9JWblUKtrmfr2uDkVrzukKPavLGoGzqkOZOkrZx3q8ampr9KltG+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pi7mKrpz; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pi7mKrpz"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-488b3f8fa2bso113715385e9.1
        for <linux-iio@vger.kernel.org>; Tue, 28 Apr 2026 02:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777368980; x=1777973780; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/jLRNwHr7auelyVO83HtYYK5qAXRWo3niE2hSctyKqM=;
        b=Pi7mKrpzepJQVTqzKTt+8mWlRfVcUwaPHIM6nyzbVuCWSmVQk3K9fwKXpjvd93I5vi
         o5TjFBViamvSFURPnnj69DN8bt+5V+UjqunrgEeWHWeTQSeOF6RQLHDif40MMtnaeQ2j
         bjrtOZqxctYMQaiXttBWfP+aaiktxNQHiVUE6+rLEgnXRH3KwcfQAv/ed8R/do2neO/6
         ixjumM+dHeuiiZcBpwjo3+VABRfv+2vw/t0Zd5t981O3YvuIyYp9lZCOVhCdkOKSFmVu
         4Wx8U9cJI+N/lueEeumtQliM3xVB2o3Dy0AIabhJiTeEePrlsz1GqsK/0LzzPBvlTWFd
         D3DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777368980; x=1777973780;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/jLRNwHr7auelyVO83HtYYK5qAXRWo3niE2hSctyKqM=;
        b=mn3izNtUw0NnMVbKmPzPGAAvlHSCP0U1Q4x6qcFyFRP4fUmsEgw/+EIu8a77S7y/wV
         OPZiiQE8VnzaYXNsLEun0kZdM/fsE+eaK99th+lvXEgr5LFbJkUES1558T9D7JzWZ/FG
         JoDrBicxe2LzXkYGNtb0TjQMFw3nVCK6pwkGmNWoqfKM8U3fch9FdlzLBnMhcnnPrCZD
         FjEGir3zMTXkgDxyq8um7XNgwp3nYYsrbPCXWB21QWdJyJrivlh+r9ihpGqEcTCREePi
         /BkmNojI7h1f+drMsjdglXS8Z1LuDlq+sH5w2In0cuLd+bDzMN0nXjS/rsBe45r4EO0m
         TsKg==
X-Forwarded-Encrypted: i=1; AFNElJ+7sh5MjDp8rfziniBe40Lnh96h3AiD8qWUTy+Gd4WdMHtMY9PjTnWB/VfjmFfifAM+GKwuUMo4TlY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/RHRV9eP/StcqEc0oKyOvkMraqGxf90G09N8SbA4mKFfAKCsL
	goNpx9RJmCeS3dKlg4f0XQs4goVwWtVlNnjBXc6kUEPWdLsHKZGYzKUM
X-Gm-Gg: AeBDiev7vkw9OqSr8euzD9UZhYiFxVdwx2XoiAOZ/A1INidcnQUfJXnIZTkcVgNLCW3
	lq1Dqlq7bzd0VXeDU/k0LGX2q5LJIwtCZRXV5JT5LA125K28SqTfJWx/Pda/GmWg/2ChGoTZEJE
	fmy7GUXf1y/RFwb1+ISC9dnjuwjo01IC8TBFqkKA5qOOwJEtfbrhfSwfaYWGjmjI9uAiay2TrgL
	JZiRywt/MDf4RW1Sifh9R0OJfVi4cubFhyC/Ff0WHjCwn3QydznR6pgEe/HZNhX/HABDG38JfUx
	PyRdh/LQ00xkejpVmWPFN8do3vASkHd51DLcyT+F1vFk6+iGDI3NA8pJF2OQ5csC0AH9s+WJ3fv
	sU8T13VASexTFCiOTFC0mXepQV5t1etECwLXGKDVzfCTNueifSRhN+1zxWz0ywPv9ALfXjMqwxT
	o8EG7YP2DFVx55PmOfMt8CJ25s2zAVKNhuLzyR0UsCvBvKRFkx8uyT0qimn339YUMbJaBWCXq1H
	lM=
X-Received: by 2002:a05:600c:3ba6:b0:489:1baf:8c03 with SMTP id 5b1f17b1804b1-48a78a43734mr27693135e9.11.1777368979518;
        Tue, 28 Apr 2026 02:36:19 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a775ea85bsm21487095e9.6.2026.04.28.02.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 02:36:19 -0700 (PDT)
Date: Tue, 28 Apr 2026 10:36:17 +0100
From: David Laight <david.laight.linux@gmail.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>,
 antoniu.miclaus@analog.com, lars@metafoo.de, Michael.Hennerich@analog.com,
 jic23@kernel.org, nuno.sa@analog.com, andy@kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Andy Shevchenko
 <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v2] iio: adc: ti-ads7138: replace kmalloc() with stack
 allocation in i2c_write_block
Message-ID: <20260428103617.148027c1@pumpkin>
In-Reply-To: <3512cce0-6660-42a9-91bb-07e78a002205@baylibre.com>
References: <20260427112705.71138-3-giorgitchankvetadze1997@gmail.com>
	<20260427143137.27bc4552@pumpkin>
	<3512cce0-6660-42a9-91bb-07e78a002205@baylibre.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 Apr 2026 10:21:37 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 4/27/26 8:31 AM, David Laight wrote:
> > On Mon, 27 Apr 2026 15:27:07 +0400
> > Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com> wrote:
> >   
> >> The ads7138_i2c_write_block() function currently utilizes kmalloc()
> >> to allocate a buffer for I2C transfers. However, the length
> >> parameter passed to this function is strictly 2 bytes across all
> >> driver invocations, making the total payload buffer size exactly 4 bytes.
> >> Invoking the heap allocator for a 4-byte buffer introduces
> >> unnecessary SLUB overhead.   
> > 
> > Have you confirmed that the buffer is never used for DMA?
> > 
> > Provided the lock that blocks concurrent access from two threads
> > is actually outside this code, a buffer for short transfers could
> > be allocated within 'struct i2c_client'.
> > 
> > 	David
> >   
> Giorgi,
> 
> This is why it is important to include a changelog and a link to the
> previous discussion [1] in the cover letter or after --- in a single patch
> when you submit a new revision. I think that would have answered David's
> question.
> 
> [1]: https://lore.kernel.org/linux-iio/20260424081809.61841-2-giorgitchankvetadze1997@gmail.com/
> 
> 

The thing is I remember issues with on-stack buffers being used for
dma - which worked before kernel stacks were allocated using vmalloc().
One of the solutions to that is to use kmalloc() for buffers that
could be on stack.

I think I found exactly 1 call to this function.
Indeed, just inlining the logic would make everything clearer.

	David
