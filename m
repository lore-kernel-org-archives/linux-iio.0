Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794018404;
	b=FWMRlQb2PGRPJahaYkUqoGZtpLYtVh28UqQRU5pAzZCepn7WwXL8DxC4kISsKhbbDDiw
	 UGHnZ93o0fnDNrvRboYOpqlSx7XwaiRxljX6WHOWxasQyANZ5djpyFlehomGiA8YGL3wq
	 Uw1Iok5nSn5rItP7zo+dSQ2s+GsiOV9NKQQHj9LB1ZQA2vaWVMZeXSW7TkB+uibfi+qwV
	 5dNXwjjBeLNV+nOlM2Mb3vDT709FvB6GQGF9amfiXqlBmMhigXnNdhAvxJ3+JZQRS/9mv
	 uog0KnycSlHDfH5Y1FFmLUHyRS9XcaZd9hDL/qfjeUTZ5aXI7P6u4T2UaMdsFYxHzSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794018404;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=dTmNgQWH0Q/bbOXKKB66f/AreOqKDIwFSb/DwJq95AU=;
	b=ILLyaas9TkyKxJhfGXxaAaEEInC8KWrVZ0dqaeKDr8pQxPIvJgLhQcjLQVL7+6VfLt2l
	 2OcfzjitUQ9tZmdCsLUpxwatcNvPkegrDmUiNVwW4f4DNuD6zFBCoX0XvV0q56h1fAdK5
	 ZNQicYcS6grvCGn8+Q6O7gcjLKknPE3pCQSWYm8sv5xKiNn3Yv9o54JogDN4QZsEmqlVg
	 JaPsztZG7fquU88cYHooY4Q7bl8MXseAKDU/QXl1CYJqTdYnQkM6vFGCO3D4/0+0roMjL
	 LXXSB4Frz5vpbharUcwQyAC4FXzg2WYkvbQ4OP24dPv7FUjntuZ8FXHdjD5dDpcGgag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SlGtEVBD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30290606A32C;
	Sat,  7 Nov 2026 02:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SlGtEVBD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B75021F0089F;
	Sat,  7 Nov 2026 02:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794018404;
	bh=dTmNgQWH0Q/bbOXKKB66f/AreOqKDIwFSb/DwJq95AU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=SlGtEVBD6uGFfjM4NTHqbq0NwxOIoAz2ymTcdtcZILzTGvZc/TNjDDvkXjTo0i3+M
	 R8K6vHp8FqxoXsSvkxfD/PFHDAulV6aO9HC9JQ3KgghgLaPujD+eMNT0ubhnorkWQG
	 7IvbXCa0q4mTZC9SAn0qq+dyPp820UI/IV6UMv7Ni0zg6AbNhEK4ZyFR5Wt4NvEgel
	 irRrlvbjgkfwxvhqEexBHcFe8rcXPhHBaj6F9X8i2cd/hIWVgrvu1wIMunsB5HLQT1
	 Jdpok9hP//U2PlOtK7J1r3s2YBFaBzmjDcZD+OZBTtjBfc7IOi6C+QhN3Ic49U2kwb
	 k488XThYr5TcA==
Date: Sat, 7 Nov 2026 02:26:34 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Christoph Rudorff <chris@rudorff.com>
Cc: Linus Walleij <linusw@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Bjorn
 Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, Krzysztof
 Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH v5 0/3] MSM8916: improve gp2ap002 proximity sensor
Message-ID: <20261107022634.36ce34f9@jic23-hlaptop>
In-Reply-To: <20261107022513.3c729034@jic23-hlaptop>
References: <20261106-iio-light-gp2ap002-v5-0-070631a7252c@rudorff.com>
	<20261107022513.3c729034@jic23-hlaptop>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 7 Nov 2026 02:25:13 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> On Fri, 06 Nov 2026 10:33:25 +0100
> Christoph Rudorff <chris@rudorff.com> wrote:
> 
> > Samsung J5 is equipped with GP2AP002 proximity sensor.
> > Unfortunally the driver wasn't working, no irq received.  
> 
> Looks to me like you've addressed all the feedback and generally
> looks good. So applied to the testing branch of iio.git.
That is applied patches 1 and 2.  Patch 3 needs to go through
the appropriate soc tree.

Thanks,

Jonathan
> 
> I'll push that out for linux-next to pick up sometime next
> week.
> 
> thanks,
> 
> Jonathan
> 

