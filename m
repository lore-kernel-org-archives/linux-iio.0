Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2E73B894F
	for <linux-iio@vger.kernel.org>; Mon,  9 Mar 2026 17:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773077163; cv=pass; b=H2GaQJ6UP1uMhV0lGVbYLVrd9ACDskwhgKfdFJqnuKty82g+i2xmpsyfN792ikaBvYnkZhVQVN+a9r9Jovz/16IEC6d0BbZ9x9bn6te9XG7eSiEZDk3Wlbl4L/t1CqzdqsJvzmRAB1rUMaP1kO+ooKOMegN/FIKqtamygUQjkm8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773077163; c=relaxed/simple;
	bh=c1Sl/2ya8NTc45Xs1lGaBgBuoH7r0Lfk5k8OKZkol1A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OKsuO4pTwj++C8xKEiJ8FaPral75W4/M0r37t1xv5Yucox8i1RR1UJ6fRqgXyvHx+FQ9e93bDexOVsQwz7CZ2xaxxcszcJkm4KCJuFSOrQfpYcBIEHwdNuQJnOQgHNwK61QflPRC2YIapqlzxaSj4dsyZHUXxv0v4O/P7Yuwuzs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YJlyWU8I; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YJlyWU8I"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-66281b1018bso1922801a12.2
        for <linux-iio@vger.kernel.org>; Mon, 09 Mar 2026 10:26:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773077160; cv=none;
        d=google.com; s=arc-20240605;
        b=YDq6eEq2UDu8/pbzJ+oJ5QTifbc5IbS2FKh4jBwA86UyyZy2sO3kF3A9OjHjuu0vwB
         YUIX8eoPqOQc2DAZSTVu4+vMBihZWLewHKLhGPAXCNGIg4/VH4WX5Bc1KXpk4EO9ZSWm
         EGJRgumlbQD2XG8tRpRNKY+wGZFuPqT+vi6xBNiMulL1FdtaN78hK9u+Yf58lbSBQxiM
         jKNSCdzI6aU87RkWDSoaYlg/ENo13+RT16mzN1QmjtXwSrWep9STai08VgKUK+EqrVn8
         TUiM8saeP4P6WcrxvlP1sOpk6vXEQox7GoJT10QwNgcIXcUNYxvjpPb53TydldLvYq1C
         jvWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=c1Sl/2ya8NTc45Xs1lGaBgBuoH7r0Lfk5k8OKZkol1A=;
        fh=wqJJrYJu6KqULULU+r8+KiLpty6wChmAe/h6Q8p8chU=;
        b=Ye4KE5EihnUFw9UU0Fx+N3HuJT7j3iack2SY7PXr5fMKbHvp4cwBPgktTXg7mI+6LQ
         3qnnsDq0aim1i3uck0TShjqtM/ILuRNc+jAj0N2Zq1vaU/0si32gXvM+Hhz40hcqd9CW
         //wMyjrEFRPzkoVKTbD8XM/m00dCKwIU44p/86q1iVDPvDmt8Wr3F8onzgw6g28rryWp
         ff6Lq5Ao+LGAN2IJ+hAGPsHg83GuC87nNutLat9K+CH7dPxAYXAPG4sZr839tXNUL4ag
         RnNUfOJ2QFyCzWSUD0UJezoIG6g97CZTAk7MFYUsIaGxIDIo2PC1YGxMmzPCP/Ih7bEU
         KFZA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773077160; x=1773681960; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c1Sl/2ya8NTc45Xs1lGaBgBuoH7r0Lfk5k8OKZkol1A=;
        b=YJlyWU8I+LpY4xb4W1PrkdZiluAWzD0tmIHOxE6edbPk967uXhQHBsbEmYJor9ATdx
         oaQgd+dzn3SYwX7vLNI1dr/tUlT1WQO5OUG/+0jNnbfUZ+4lUhK5wlWciPYD9klPAoKh
         dOedDX1qaUqkBdr8ZmXt8EfjM7ddrLzl58I/QGHVlbdOtbcOna9XvMvEz2ROkYVvHybQ
         jDVkKex/np7uICvGrFLZWznGj7/EoovjwNF2VZ3HYxNYYNiboxTZSwYb4QySgwbrfc0M
         ZCmWNUY7rn1FgNUna6qH8hj477WFBVmC5rWs81cen7tsCfd329V0Btqimk+boGu+XCsp
         fRZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773077160; x=1773681960;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c1Sl/2ya8NTc45Xs1lGaBgBuoH7r0Lfk5k8OKZkol1A=;
        b=wnXaCqcg5yNxk3aDvlexllBxP1mJEOkUpjWPao6UQdVNvGLqA2AO9w0kxhFgS/agvk
         +Xcs7MCrHghHnsPdWtwRncDRvJFZgMM4NH3YRwRF9sfkvMbLtcfF9k6nlM2mdnRNJeEP
         ps4o2ux6zhnFT45of7+jpdinXrRw8BBKzYPE/Io4pHUS7P5LAJhjkdmT4Xc8FPQYomzE
         sanOSykIdBCJzU3PCypcmTM1n0+8RkOlLN9FvMnDzmd2PksHpxE5B+sCQ6hW6R/kttxE
         r70GVeoASsz4BjlRDceTG4RFJiPkf7reSGlwIJdcdogpmUstBIABKYuezGdGYdM24PcV
         007A==
X-Forwarded-Encrypted: i=1; AJvYcCWHkl2rN3OzRXmoz/rVvA/70sIKA519gppLAKpm2xGXY3zUmjq4bq1VIduIVJAeKycdQ5gwtN+dtWs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyyi5NQAcpCtasDdWr1zDCYNEs8k6PXvc/iRsJKyTyH7VXWkaEL
	wN/55FkibCy6CsZTaEkDu+lB+9QiI1Qkqqu4m2EO4YE/4PjWU6rMr8kLrKJzqbsLxsopKyati1P
	WIvBKu8HU3sIdB5/RB8nadf5wR7SVKZI=
X-Gm-Gg: ATEYQzx4RwVR2nM+3MVRx1Ey1OSVzP7vidBxg1riCFG+RYDmkemyXME2G92wf3QDEUI
	Wz1lNZqNMJvIAwuraecJovxaRWV0PxUaVGlKrLrlAuzH5AenDcrtoIO6ERbfOcxCZhD4UAriREt
	ZNFK06HYqZJb42PPv9FAaVs4qsCmxjV6KyFRp6g4QNVHtV8AJuivaEhMiO1kvLNL14JIwr9BrDF
	lKW4GOjomX4u+ROuxpkhnNC904Gjh0MywF5qGVNQSFBfhph9SZxGQPGvIY8KOfk772PkMQWmNcq
	kAgOLBwRpurHGoKicGmF1pQWSFf9n0QRmhMRwcAMf6WZA6J/3YsmRDxOm449HMufiNuonPdvneW
	K2t1Ier18rkZtNmQV4/giPw3QSD8=
X-Received: by 2002:a05:6402:27d3:b0:64b:5562:c8f4 with SMTP id
 4fb4d7f45d1cf-6619d49a0e9mr6331242a12.7.1773077160083; Mon, 09 Mar 2026
 10:26:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260309142352.57407-1-rajveer.chaudhari.linux@gmail.com>
 <20260309142352.57407-2-rajveer.chaudhari.linux@gmail.com>
 <pndeclt5aup.a.out@axis.com> <aa70ngEIxDNPYqky@ashevche-desk.local> <pnd342954pa.a.out@axis.com>
In-Reply-To: <pnd342954pa.a.out@axis.com>
From: Rajveer Chaudhari <rajveer.chaudhari.linux@gmail.com>
Date: Mon, 9 Mar 2026 22:55:48 +0530
X-Gm-Features: AaiRm51L0xcJfmL66DtjtWEub0jAxQAnB00BMWPXiId9hkVAkiuV0NiUYllmXDc
Message-ID: <CANS1UbjC5OaTc+esva2+xnxZFQsZbRyZ6gP1=5EAsnwnpM76vQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] iio: accel: bmc150: convert to guard(mutex)
To: Waqar Hameed <waqar.hameed@axis.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, jic23@kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, linusw@kernel.org, 
	sakari.ailus@linux.intel.com, harshit.m.mogalapalli@oracle.com, 
	antoniu.miclaus@analog.com, andrew.ijano@gmail.com, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 9, 2026 at 10:18=E2=80=AFPM Waqar Hameed <waqar.hameed@axis.com=
> wrote:

> Yeah, I guess that's kind of the issue here (or in general for kernel
> developing). Every sub-system have their preference. You just have to
> carefully navigate through all of this :)

Hello Waqar,

yes In one patch in another sub-system, Maintainers told me to keep
headers in alphabetical order.
so i thought it would be a good idea to arrange the headers
alphabetically here too.

Thanks,
Rajveer
