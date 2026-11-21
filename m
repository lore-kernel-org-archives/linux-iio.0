Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795225155;
	b=3fPjgBvT11SRxry5/qHBwNsm+mS4GJsFZL2zFYzPjyu65dZIqVyY3nyqHZ8l6AaISrJz
	 2ZjBL+hXsZtip1+a537KR1HGMr4QguJY5Dm5bt8vIyuQRPNeizuscazG4TQLRHrHixwSA
	 Ae169ngphascCv6H3V/lyw6PrdO0bWVLqi5mDPYYD42rUxl9S2aomTcyqpWWmbM65muXO
	 WjUC3lAU4SUADX7WupT5vk/yauMnxWdlualgavFFB2808rlhdeHoWiCvl/ePUufNOSYpO
	 UwIEp/Ifkgr2lL8G0WAccHt1DEuCyug5BCfNBCEQomXmdh4qcsW6ad/7aVHlu2W/hSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795225155;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=xkIFUE3rSguA2k8pPYGYGiPVAWdD1uXdPaRAnWcMV+A=;
	b=2qSZpDsEDCBJaK83HswsPOLoEQmYMDkqZ0pU1R074T0rl7OpM8FRaywndJwPNle7N+wQ
	 RGgM0PWm5G0ffEaUkoSYLYtpgy68dJTF/1MOdyOSd6Ul7mqx0nu8XPljE41WTSTRzSj0a
	 XtFmSEzTpD73heJEcZ/jOd8CoIlfN31XZHVujEbYvGafoHvvmEvtdNW04fwjFPhkffYRB
	 b1kaucN5RHah4HYNhIDsCilqAfyr9wjxNZXAbDMJvZbUNv5FJlaSXn9u99VBx+oS0Oa+2
	 Ecx1xmtRLQqaUqxoQGdzMormzr1LsEYyeEmuFYwx2eoCtFjjhszAp0hFTs//NZrHyZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hh6OG1vv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72FE1606A6A2;
	Sat, 21 Nov 2026 01:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hh6OG1vv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61E721F000C0;
	Sat, 21 Nov 2026 01:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795225155;
	bh=xkIFUE3rSguA2k8pPYGYGiPVAWdD1uXdPaRAnWcMV+A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=hh6OG1vv6ngyV+s4Axqcx+NBUjziANO9mnX+pIscR4RFOSGUnnsZSsPW2vtsZ23f9
	 m4yKtHrKAtdNU4z5ePD/nVrR5ezOIZ0iAnwZzXimatu0tgqHadAS8posYHCoAGH3TI
	 f3LZEXq6+q/Y79Pfs6uQx6Hc0tTsXe7le+p4pUGi742mgagMd163ECLtx3s1EvinYk
	 Werkwwb5JF2ZnrmWXtRqsZzj5PwrUrd0fVmShbUmarMCJqQ51s4JxGoU+AhLp2F0NK
	 oncE/+kstCuoj35Xyra4MWEF3w6d2lD+79YwxsVM+4onPqYwz7hemtAcPVe7n9Ea9G
	 wDzkbRXFv8ncw==
Date: Sat, 21 Nov 2026 01:39:07 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Alencar via B4 Relay
 <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: rodrigo.alencar@analog.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>
Subject: Re: [PATCH RFC 0/5] iio: split struct iio_dev_attr into typed core
 attributes
Message-ID: <20261121013907.5e15d2b1@jic23-hlaptop>
In-Reply-To: <20261120-iio-core-attr-review-v1-0-05b41f8133c2@analog.com>
References: <20261120-iio-core-attr-review-v1-0-05b41f8133c2@analog.com>
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

On Fri, 20 Nov 2026 18:03:56 +0000
Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:

This is missing key thing for an RFC.  Sentence at the top that tells
us 'why?'  To me this looks like nice work with no obvious outstanding
questions so not RFC material.  

So unless I missed something, drop the RFC for v2!

J
