Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7EB83CFF69
	for <linux-iio@vger.kernel.org>; Thu, 21 May 2026 12:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779366323; cv=pass; b=n8RS7fUYoUTLwWQYNNclPQlSb/xZ9He3KR9kGVX6xylenfnr0KSlgnCaWV4h49wmAnOoI+TUZXJVQaa312Sh4Y9afoDtWkZ70fCWzRfaCOLKggAXs/nzkRvM1awByeOc39AWSPTDwMwcW+KYr87t6p7Ydm7tmSaoQfRj5V/Trig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779366323; c=relaxed/simple;
	bh=Gyzw9BlnoqrnIoIhn0ThtE+G1wDJ/t+/85iGkXB8W1I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NUS6b+MY1P0bcGXywEksHQN/5E1fRV6rrM6mHwggfUS/zQ1mtDKJA9pJIIIEw8oIoNpVlQrgPN3k3glCnqavzq6DdJcTGwNL2mqQU3FyfLN0g8LTxWg11NSqcmGWsjjpfd0JgFhznyktzYQd6bwyYvj3fi6yK26vwLRpBtjOJ0w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pBO0KRi1; arc=pass smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pBO0KRi1"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-8b74b460d77so79467196d6.3
        for <linux-iio@vger.kernel.org>; Thu, 21 May 2026 05:25:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779366320; cv=none;
        d=google.com; s=arc-20240605;
        b=X+qC0Xm1GJ4QinAzWE1arS660dhxFQkQDnvfX6Vu3iVkchOp7snn/rFp3wYRNcZ5nb
         EuLYuW7kkgF6F0vm3ps+84OKmDmO8qCDYFRKZ1mQ12kQh5gJhyUoJy1Md4dYwMyGw70P
         jVJjfwWA/GsoasM3Y8ZLysz82NUSXJ3vfc2Y66emVLnELLZgrV0F+HQAfeLk1v8FQdu8
         mhrpGngfUcgmEvlM5NeWXgbz63uQG0jPQ+xuiiLajQSvYChHI+xJAXL8cU1FjODsa/kP
         e5MCr3RDqr50Ke8vsx6BlaCNr3S7zpvUmirehdowjxgftq8FJemAsFjNqxH5ij2/0Ilq
         hOzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Gyzw9BlnoqrnIoIhn0ThtE+G1wDJ/t+/85iGkXB8W1I=;
        fh=zSbnTYMaROW8JLc8BAxYlwY3DsMzBluHq28BiWITD24=;
        b=AavSeJDnFudmXT/3opohV3tWOH3q7XXvsxQL0H0ipwzFSuDCXXDRhfUr2YkXBSMbAM
         Ee2Xags1G5FzwhnUMzGOd6xkAWzPhyHDBfZfmQNZUR7z6IvIRrFnu6Rm9LfBnAEL9qOk
         2D64L1rcHBCJlxC5sps40KAVSA+w7LwKCy8XvUKPVD/v94xxbB8xdoHmdh3tZQNXeqPB
         d6HO6nWl91DTChxkogk8e5WyIRlxhVJCCxwKF1vrnnCOt6cbeK0R/9J84bscZfy2BoNT
         akGS5V1IR4s911w6rPi+72uFXoTGXTTMWoEWd3698Fl7KFo3dad0RjLN7IYPZ5cxVgpX
         K4zg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779366320; x=1779971120; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gyzw9BlnoqrnIoIhn0ThtE+G1wDJ/t+/85iGkXB8W1I=;
        b=pBO0KRi1f+xBlwb5Pg/GYfVVhegyJUTx9+S/ALNX+vHyKNOZYYbIyvBpeMg5Bgvvxq
         MvQ7P0fPXc++nX6uxLFfaz5aPA1w5AL4vdGLYbErY0oipUh+6W02vypCuqym8jYOlCvK
         ZDCbluf+B9bzE3AR/N8kUdUWWaDvBIoG3oc/ZvDSCfd0YAvc8ynLUTiLHnm1JrLgVImK
         yo+UG4ZRs14FEvtdIuK831NlVdU5qWQIXYQSypiko7863Or9cOUgfDxOxwtGtH9G5erb
         tKCFlHBU3DBE2DmyyS3LxBamfQtmgvUCnAA1SSF9uaIrdaXsp9fzM//s1QccXSLgqchk
         PzeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779366320; x=1779971120;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Gyzw9BlnoqrnIoIhn0ThtE+G1wDJ/t+/85iGkXB8W1I=;
        b=ktpeK1E3OYqbJEob8hCkqKNkKrQjYuYCpw367X/DBGsGO0vPrO9mfh4NmZfFnQgdRK
         J8fgd5tf04a7TdYjwVg/kmYZg9jRsneo8Mb4piEkJ3dgfRdW1g6e/HXDHrNXFMQAtjll
         fTU0sfqVuW0ZIUeYbdEXJdb+pu8Hb7Si5ndJg5EBaFKrgOylyRPtAGpo89CqJC9FIhLP
         033QzP20QOugycimyfa0Z5mD0TWSmDZxHTfkyYzOKunvfKoJr7yO7pwyhfAsDlYlNCiX
         7RfKwIbGmtbek8ZaXgzs7a6GtQxirCJZLkWh6XioY6Knf8p3oUjsT3hTsLQM+A/fVo4u
         lk8w==
X-Gm-Message-State: AOJu0YybPOzUeA/IKIPy0TJXiy6BGQqUxV1hBKA1Mwvu5EbVhH28jD6I
	k0NdrXkHSFf0ZXmTtiOajqtQ4OS5P+/9tyxs3aLMlufpst5xSqAlmmS3GgYJm8YuEnIRj3fTPyI
	hWmSq3EJcUCS4V/R4PUCsTVKUDNceYp0=
X-Gm-Gg: Acq92OG1Gfe67hkGujWNmPx5skAhP1XbbZMVNiAZ5Cz2UDGxBRopaBdeRwH/5qYbsAN
	vsRoJMRCqzbWik76JHMEdC7w2X1pB7a6vpr//HDrbPie6aYI5M4ly9JnmJJJjv1xbjrppnQQYp6
	66rGkRVM0anT0ZtTkNfm+44YMvItusihr7kmrj3i+Yz6Ev9ZELVsEDfhNwW6UAp3wW0nqQvH5l9
	28v1nCJWy+FnT3bsqBXFolomSwl3epRpm0Se+fnqOxoGicwhTit8D3r5GDwhZ0s7zy4m594A2IS
	lkPTRCXhPeSYWP7zNhbdNET8tqXoP+0CIcLghdax
X-Received: by 2002:a05:6214:1c82:b0:8ae:6d63:3066 with SMTP id
 6a1803df08f44-8cc6e386740mr40788296d6.38.1779366319700; Thu, 21 May 2026
 05:25:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518165320.1301071-1-zoone.rupert@gmail.com>
 <20260518195838.7afa1808@jic23-huawei> <CABpb+S7rW5c_40eCLesRq8yVeUziQYK9x8Uy-FBJ4z_JqhGPDQ@mail.gmail.com>
In-Reply-To: <CABpb+S7rW5c_40eCLesRq8yVeUziQYK9x8Uy-FBJ4z_JqhGPDQ@mail.gmail.com>
From: Rupert Zoone <zoone.rupert@gmail.com>
Date: Thu, 21 May 2026 15:25:07 +0300
X-Gm-Features: AVHnY4IvUzu93jLWac65lv2mvP9HwBB4zJu2i6uq2BpNOYoFnzEV8gITtLAjBQA
Message-ID: <CABpb+S5Vb2LfqFR9UmOf=sTjyQPjjmp6DK53dT12348k0YhfOQ@mail.gmail.com>
Subject: Re: [PATCH] iio: pressure: dps310: add FIFO support
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, eajames@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Jonathan,
Thanks for the review. You're right, this was intentionally the first
piece, with the IIO buffered interface as the follow-up.
I'll fix the style issues and send v2 as a proper patch series along
with triggered buffer support.

br,
rupesh


On Thu, May 21, 2026 at 9:48=E2=80=AFAM Rupert Zoone <zoone.rupert@gmail.co=
m> wrote:
>
> Jonathan,
> Thanks for the review. You're right, this was intentionally the first pie=
ce, with the IIO buffered interface as the follow-up.
> I'll fix the style issues and send v2 as a proper patch series along with=
 triggered buffer support.
>
> br,
> rupesh
