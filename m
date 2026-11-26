Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795699242;
	b=C7ywgY8CHpcWB/W71670VEkI01bSTLn5dZm+Z8LPavtX+2Z73O+CkSE2F2lS4PJQeJ/+
	 0uA3D3pGjInOr3zuR56wGjlA4R1JJgquF0HK+Kuo1mBEcDGoREOuy4hjAtPrkEhGg3oQY
	 GvTyBPQD8Mpo2RdSY6KBVQ61KJ7N9gqQb0/quwJUs87Qmj8yxiEdyNhm1v4u/Dqc43Bqj
	 Z7nESkTTJoWS8UWVchlfhnshfbnNraQOA6OmfIknckPv1wEiRrJTb1O/EhVSHrqedHLm3
	 rrBRM6k07vOR/DhDzynmbwfYx5+aWH155n8+ZGPv2xU2EU/GxksgUTqgWwKK9gvAs3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795699242;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=YuY6LirKMNOVZBi7SrklJdWd/Hw05axfD5xdIOgyChw=;
	b=CrGP7T3ju+jZJhYCYpvqoD8DOLzzSWyIA2H8rxglI5sv1gIfDv7xtOAM7GvQp6PPCrGl
	 Niv4jWHHUIqYPGXX3F33ljoZnbH197ZNUrU/isNLwwVRlv8K7CCCOOFZFhGOJzw7bfBTU
	 QCXyCJAY410QckiRfMrAKU1UcVFQ0NHcBkha1rv+6sYfFzarYKlFBTnJkdc/dfPewUKD+
	 qyzfrOtn7EWymgryROhmxnoF4y7O4aJg5iDKUCAS4JXquAeT4rZLxViKwNS6yjbVzM1Gn
	 drtF6raK6TCG/Zv0LbW981FMNXJ3y1NffWV6gNaiCm8iKlf2rMD7y2A2ai4iPY3Orpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Durb5aRK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD65606A31C;
	Thu, 26 Nov 2026 13:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Durb5aRK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B967E1F000C0;
	Thu, 26 Nov 2026 13:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795699241;
	bh=YuY6LirKMNOVZBi7SrklJdWd/Hw05axfD5xdIOgyChw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Durb5aRKnoh1k0knBK80U2sdz9u28XU9YSQUJvABLHyCZBku4c1cJS6982DezV08v
	 GtmOg3flO+s78EEsOLmz9ReVvJDuWkeuxJn19bnMiMnckixcAlZfds+3WinbwaUHWI
	 3FvrKrmj7qd0bQQn7TAh6wmQJJIKxd5KGBfVMOrdYrz/SIMP8Vw1RkpAHdLNeEcbGj
	 YxqB4K6okmF2oJJUE9WN3SFFjxxmSTMNs6GC8u5fUk+CB2Xqr66NYGH3rLuNEJzBJh
	 /629lEwinPGqqTpLW29aItXSzvz97zrARjvqkXJxlX1MwK8H6wlzJuxtFina7395jn
	 A4370Oc9uqcuA==
Message-ID: <0662bdc4-0182-4236-9c8e-5e1b7146a436@kernel.org>
Date: Thu, 26 Nov 2026 14:20:37 +0100
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/7] iio: pressure: dps310: sort register field defines
 high to low
To: Rupesh Majhi <zoone.rupert@gmail.com>, Andy Shevchenko <andy@kernel.org>,
 David Lechner <dlechner@baylibre.com>, Eddie James <eajames@linux.ibm.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261126121331.10438-1-zoone.rupert@gmail.com>
 <20261126121331.10438-2-zoone.rupert@gmail.com>
Content-Language: en-US
From: Joshua Crofts <crofts@kernel.org>
In-Reply-To: <20261126121331.10438-2-zoone.rupert@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26-Nov-26 13:13, Rupesh Majhi wrote:
> Some field defines run from the high bit down, others from the low bit
> up. Sort them all high to low, as the datasheet lists them.
> 
> Suggested-by: David Lechner <dlechner@baylibre.com>
> Signed-off-by: Rupesh Majhi <zoone.rupert@gmail.com>
> ---

Reviewed-by: Joshua Crofts <crofts@kernel.org>

-- 
Kind regards,
Joshua Crofts

