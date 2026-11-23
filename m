Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795439876;
	b=jIK3CMKAeLRO3HXQOlyZ7OwnbA+AlJHJ6kWJXTDJAov8Mw8dSacZMBxToiqZvyyh6vqS
	 BaKbufYpKb9EpJuFJGfHCN19mMStPufUccRNP/+maCiKKt7fsGb9hQJcno97wa2IRknu3
	 9nFDhSdEmsv7cIRdD7uXb0Rno+VIQuA+b0fBUjw7/T+wqohuvCLvZuJVUtEB2q6NQOw5L
	 AskRk7a13MBIB+wYp9OdJGuiORFV4VZ6arjsp2CkNxAphSgxq7MNrXtT9jBHLvAG9mAGs
	 sefg9JuBvwn8h+1OdttVD7YDrrALd2XnaniWxcSeWPHvlTm54fE0AgJhVmTuifuQMRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795439876;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=aqM63nnQK7AZCxbMeML2f0tMbQ1WjiGdxoWJz5+hbwM=;
	b=DEKUltVF1mjHU2m9Qik6CZ8p/E0adaABqr+tRWtYfAjDBaF3/ctF5siuMyRdSv9Ra/lh
	 EHIuHej95tnSPbimvIcIvG5eHZbwLXNwV0bpNGQiGM96Mf9ptcKw7ZVKpYxIngAIp1+sD
	 L2/bZBGw/gYh4LX0e+VHJzkdnEqYbl1heFnz7eAwSIINoTeKHYNxSD3bvTe5bd4voQNQN
	 zswyTXkNEFOKTyMGzt5NYqoSkhkIjW9qK2EBlzq5udedlhvcFvC8fWMBEtPKTs2nhCzb/
	 Ykrhy+JNiVHdNdZ8bWcwOdcw26sojWc2ZVqq/U2gu7R5ejSeklfH1UMq2evAGgJTLJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tdMfgzpl;
	arc=none smtp.remote-ip=209.85.210.175
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70D8606A31E
	for <linux-iio@vger.kernel.org>; Mon, 23 Nov 2026 13:17:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D70D8606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tdMfgzpl
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8b29b83fdf1so1607086b3a.2
        for <linux-iio@vger.kernel.org>; Mon, 23 Nov 2026 05:17:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795439875; x=1796044675; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aqM63nnQK7AZCxbMeML2f0tMbQ1WjiGdxoWJz5+hbwM=;
        b=tdMfgzplRXOZIIP0ZgnOxEtGeNma0sX7iehF+JL/oob0vU3FsnIrCTY32oNWGOFxoo
         7JhNCAw3xB1ZixXe9RaeXGFri92mqDi8stV/OipvXCX68BKzNOwc5YozME409r1N9bq1
         9Yffhx+YgipdxCGI2RkcMzpAnpBzx6GhpzafeIB7UKai3oYQW0f3m6cAXgMwobdEUU5O
         RIDcserCjuLLJWtsl6YNiHydmyfJAaFEBD18JR/PTAv4maYFhELfRqqu60ct5lrPkMtv
         +SbkYwq/RMicxCN89q7G3djtuTDp3IrPcy1KSwF3uxScaoPN0e43T/pcIRmjEMqdBL3/
         /NFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795439875; x=1796044675;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aqM63nnQK7AZCxbMeML2f0tMbQ1WjiGdxoWJz5+hbwM=;
        b=2WqJnds3I6xM8NUkch2TRCkoT23BeT3ggU2QdBhftUf2jCjDgZ3cpHbZ5Ud6jSdyQy
         94WRiAfnrEsJxPNpis2rvpkvRJ5fn9E497lBmkkb023ofV3uuL0MPizNja3Z50O+D8Sw
         ByPXQqc5yqhEObiY+tTLugNLeWuP7tZadJjMB5g+srFr2m4K4o1Ccyepn7vwYcWbvmSj
         A0KRqjBngirKSakNLBJ3QhXlshxvdA3rmVyRub39otwgYaDVOzCpfDIHhc+SytN4UytF
         VfLSodk7SE4ZbmR9nblJG1MRhT2TQ6/zeeuwuTFoMFEcFWY5Dx26bRVoaKZfWaJ2RtOK
         ddsQ==
X-Forwarded-Encrypted: i=1; AL+hErG94vJwbQ/isPQLIlHXtn/mGxA68EUsr0/FrrcBic99VADGl6YWxUucpkubupz5yXd3su1d5inhgxU=@vger.kernel.org
X-Gm-Message-State: APuU4Z9ChOjGsUM54T7Jy/SIERzgo5otMQp+dMS6RSYg3HyCroSjQwyv
	g3kCj8mAI56kpoijKTjfpekkmcEC8gQf9rnq4X9ZnTkbPu5W171gAw9J
X-Gm-Gg: AZFdTZfZFO3Yo7Zjhq6LA2TwCYi1gcIh0StPAArNblE7YULWb9vVbTHVSZgHUOaMtbc
	etz5ivC+YnAmO8HumTPv+DPn+ssicUKN6RBFqcM0XUCMI9WQWhSa6nlLAB9Z3s89P7vWcfTYQ8e
	JMRYoYw5VyrAM8OA3k580Zg3mIykqVYwtDrVSh27CVH6AnLQNlWroP9LfUuah51uEbfriQpbd98
	BhmRjUXGc6OBjDlXgQgw00eEsCXQnFFKWUH+IwIRxJUbwt/3uMMUF5tCi43yWWWWKxOFCtrEGvp
	fQK3cXWEjtuS0yvEHpZsLXANGjLtbbf8NW95LnrdJFd99gXfdjtZYf8OGn/sa1dJkv31W7UAF9J
	mPeAwuZQoI8wuoIJWy6MYCsi4u7zmnKFpKHyTMiNhCEgNqZuBNrh9OHh7LnUi9AWpDDllMeSReX
	Lms+++/F1cSCfkup0ygRHdXIh18sYbEVwHj4YZAw4g5cWnW7/prjhasVcbgIseUN+5L6Q3PcX3z
	GJdccAzucCLeuykl0ZpRpRLzIKb5M7++Z0Ad1RxlmmSVOY0r0u4XlUdey9OrJUWg2rIxAl8GjcF
	2Prr7CSYuzQs9MwiOMbUtMBD5YYNaBV+0h/5iObbr+KJut1jXe/n0mYhnJySERRH8tnq/F0h2Nf
	w+hOgOHpp36uFJ88Y+kz4wAEVF0xVBC9XdVtDl88HMa9Otzz200MZpsuRvb46gLE6vJY/luGRCU
	KAZVTutWVWg4wKKnHRkxVIyfK3BSQqqNfCuh42tvuWgg==
X-Received: by 2002:a05:6a00:1d93:b0:89a:5:92c1 with SMTP id d2e1a72fcca58-8c87d51b324mr9447302b3a.56.1795439875096;
        Mon, 23 Nov 2026 05:17:55 -0800 (PST)
Received: from kapoor.iiserb.ac.in ([203.18.51.239])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c873b27900sm5605698b3a.47.2026.11.23.05.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 05:17:54 -0800 (PST)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	gwendal@chromium.org,
	swboyd@chromium.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/6] iio: proximity: sx9324: fix proximity threshold writes
Date: Mon, 23 Nov 2026 18:47:47 +0530
Message-ID: <20261123131748.16791-1-kapoorarnav43@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <awQfT6jSKo9pjxjU@ashevche-desk.local>
References: <20261122074649.239441-1-kapoorarnav43@gmail.com> <20261122074649.239441-3-kapoorarnav43@gmail.com> <awQfT6jSKo9pjxjU@ashevche-desk.local>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, Nov 23, 2026 at 01:11:11PM +0200, Andy Shevchenko wrote:
> On Sun, Nov 22, 2026 at 01:16:42PM +0530, Arnav Kapoor wrote:

...

> Why not simply
>
> 	val = _val;
> 	if (val < 0)
> 		return -EINVAL;

val is unsigned int, so I think that check would never be true; it has 
to test _val, or be the val > INT_MAX form from your comment on 3/6. 
Whichever form Jonathan prefers there, I'll use the same one in all four.

> 	...
> 	reg = SX9324_REG_PROX_CTRL6 + chan->channel / 2;
>
> Note, reg might still be not used, we have more validations and with your
> approach the reg assignment is in the middle, confusing...

Agreed, reg belongs after the val > 0xff check, right before the
guard(). I'll fix it in v3 as soon as I get the val verdict.


Thanks,
Arnav
