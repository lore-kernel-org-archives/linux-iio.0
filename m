Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23AC62D9ECA
	for <linux-iio@vger.kernel.org>; Sat, 19 Sep 2026 22:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789857936; cv=none; b=dEqq2MzjdcIO38SZtNTxVMgiE+faZhNc4gUc3uy9mycgKYBBwiNstexbQwtkgaZgFT4oy4iYQaz0WGEbaAyVdG4stJGYF2aLKWfG3mNIYPkleAgEOS5C+0/a/pMn7DZqB/943ZYBjaj9pfHXFIG5QsqSlGmSAg7ecrg9/H2zOVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789857936; c=relaxed/simple;
	bh=v1kmP0B4VG3CkwdYizQTPKvWkuISr7jZ21oNuZYGynM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qqjup4beLxcTAX50WE/TDwb4GWQ0Bxul8nmmojyejY4RwD4BYtVQ+abHGnRy/NTh5omBtMQMLnmY6q7hAWQMBG76k1ytlhBby7wKgDuCv7Cv+bhK3WBjdDUQZhxzw7bbFPyJLpcgcMtUiPBJKlQJvfsPf539IYTKeYvPATMhkok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fu/75tsM; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fu/75tsM"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e620fa473so10806015e9.1
        for <linux-iio@vger.kernel.org>; Sat, 19 Sep 2026 15:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789857933; x=1790462733; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yzMtsvqNFEO/nCPDz6id0wD5s5RNIZH4rSX/yPIxbAo=;
        b=fu/75tsMPG84/w6utG7RZ0OxaVwkv2nZv1+oLKEu3TGU57aACKv2J1kPW7jQ20LtLD
         UFIz34igkds2AQcIr40nhXIf4b0Uq/PN7hrq0ULRwyObOheLCFpkbqL7k+SOoMr4tysw
         aHyOtV8gdinLCk6FOfk0uJUoMAc6xDH7j62dDOIgD9+joU4mdnZjM7JfWwEmat4npM3g
         bvrIyzbJMtKGo86YY0EgrpQ4K1lQsC1cuCmLFfjA/Cuu+/BfReo5TI6ulwpj9IOk9hj4
         fjJPVssTEkwdpAO1KAxKreRw4fYlbDSsz98oZsqLYZIPGQIkE0qYheTVZTTArE/2IW9S
         FEbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789857933; x=1790462733;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yzMtsvqNFEO/nCPDz6id0wD5s5RNIZH4rSX/yPIxbAo=;
        b=vhrUw2o/ODDEq8FPvYGBa/dJF+QFeZ2mnZLrw7PEeitrFyH9KP2gohYsEXpQrANcF9
         5Tpim7ycU12HeW1In8AQ0za9s0g2BHy+lJU5A+oPxjSHCJbp0v4tqCTfOnlCeB+HtRED
         MKI7nD6Ab+AWr9+jlIuC3GNFwYEqGq02UotlgEPLRSJT54rTGSZbpisGlhSYgQWI27wM
         VA9tInLK8kSQdK8fWqX8xIOoNdjIaDSoHQo9dMJh01BdrtuxUed65szEXtWwMCph99YX
         tsakYNzC2W2uhECxVQuhvs3VGEQPVxa5cGbmIZULoiTXFNKnLYaqkiR7QV7SswjEZieA
         Zujg==
X-Forwarded-Encrypted: i=1; AKwUvBx3zgmwGKwCzIphrn2ugeCx+ie4PdmMlh1eV1AccAvuYjouErmTunywwbY+0AgcDtIOO0hzJZdNn2M=@vger.kernel.org
X-Gm-Message-State: AFuF++mI74J8SOk4p18fhTO/A4u+WaVfeY/D0pkdZKIyKduWhwN50V1u
	71XBkPuQMcs+qtr4rZpdBM/sAIR3mIGqIbQhIHjHtcV0sW3iLFiwYvE4
X-Gm-Gg: AYBFou1PTa1gBWsPv29BlQeBJbKDunNdsC7y2YK1nyykyxnEi8jQQjzF3nkgWv6ooku
	/0ixfIHzV6xx5tlvj08T3IyYo/jPOTDFRgQrKzoz9R1yMWJMpLOOIwloMnNWxs6LFzRPIjBzRHD
	Nqo3iL4BpliA81nkEzX8pMBftrB0xP9iC53O1J3egvrGE98BFYGAqfnkVBdNe8hocLhQLQ+tKlc
	UlxB6CA5aqij2TaPV8ulv8cA9B4UHEiXVsoiLzUSBXFaf8i+mvHoE8qhBCmf0I20VGWWzn4+35O
	2ctpXhURKWqI+LnX58iR4ruZ7EH9FiCpQRQ2NfXlCsAeoLiBcgRl70/PNBLZSkY3+YsDW183zKe
	2CEGIQ5dnwwLbpf2zU/tLcZyaX1ykInyq1eVgfAq8+RkNpTKGziDF9n/Dzz4YhV+Q8Ot4j8fjHt
	xzwoLgU/e/GLxnknGrmksARLZ021LOU7d3P6GtwCmbBZvsOpddO2G/IUaojD9Tq5YHxcghKsal1
	LR6bQE44fdnZT/yODtVI4g8KU/7ROpPRldp6SbFqsE9CuwtE1BYWuHC+6o+f7N922HOP529+ldQ
	04jxcwIV2I/kxj9Wt9TNYwYrydCx9rrHkJ4wk2tE/6yQsLHT7kFj+7lIWqNGpAIuyTk/T37JK6G
	76Vb0H+mUFoNWyQT6pupTedicgR7iik1cHj4aY+lOLQ==
X-Received: by 2002:a05:600c:81c8:b0:49c:fc6c:be08 with SMTP id 5b1f17b1804b1-49fc58581bfmr77420595e9.31.1789857932820;
        Sat, 19 Sep 2026 15:45:32 -0700 (PDT)
Received: from systembl0wer ([2a02:8308:4092:11f0::f9f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4872459a5d2sm8892696f8f.31.2026.09.19.15.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 15:45:32 -0700 (PDT)
Date: Sun, 20 Sep 2026 00:45:30 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: "Maxwell Doose" <maxwell@maxwelld.cc>
Cc: "Angel2Eyes" <thefireking@gmail.com>, <linux-iio@vger.kernel.org>,
 <jic23@kernel.org>, <dlechner@baylibre.com>, <nuno.sa@analog.com>,
 <andy@kernel.org>
Subject: Re: [PATCH] iio: adc: mcp3422: use sysfs_emit() in show functions
Message-ID: <20260920004530.6eed7297@systembl0wer>
In-Reply-To: <DLJNFI3A4WZ6.1PWFZJRQIDLZA@maxwelld.cc>
References: <20260919195507.94130-1-thefireking@gmail.com>
	<DLJNFI3A4WZ6.1PWFZJRQIDLZA@maxwelld.cc>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 19 Sep 2026 17:33:36 -0500
"Maxwell Doose" <maxwell@maxwelld.cc> wrote:

> Hello,
> 
> On Sat Sep 19, 2026 at 2:55 PM CDT
> Angel2Eyes <thefireking@gmail.com> wrote:
> 
> > sysfs_emit() is preferred over sprintf() for sysfs show() callbacks
> > since it is aware of the PAGE_SIZE buffer and has built-in size and
> > alignment checks.
> >
> > Convert the remaining sprintf() calls in mcp3422_show_samp_freqs() and
> > mcp3422_show_scales(). The formatted output is unchanged.
> >
> > Assisted-by: LLM  
> 
> Pretty sure this should be the name of the LLM used (feel free to
> correct me if I'm wrong though).

No, this is the new way of declaring LLM usage. This approach was
chosen to prevent the advertising of models in commit messages.

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=816d9992d9ed434ec52cfbd63080d518e535a41b

-- 
Kind regards,
Joshua Crofts
