Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794320278;
	b=zSmA4OYe6cQJCTC4xa6a82PtSULgbv4NDF4H0esNchDACMEvr21ogodJTmd34nLtac35
	 i63I2dKzoejsVCps5s+Raof7sIwCj909Fxp1YQSfhAUM5zHfvENWmIlbnu3TljSFnJTGX
	 2UBFL90KHHqy3DK7T//uxsF5imOxu3KJU4erKOMX5IWYIdRmJy6b0NuJQxIDu6naqP7D7
	 VgONH6sE2i3PWUAcrnKW7j7uhLCNEhJdmKHObo+TaJLV+2RIgEK58eIam0iB3WWUNvqol
	 owRd4RJaixgqlIqnLNCwrzXT05nUQLQbfcUlst5gAXgQXjv6hEK+JBLdA6Bl53BMLbA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794320278;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=m9cQN4Mf0HNTTXs9cCLTRamxoxvLO8N57TLPiFrWzX8=;
	b=laRD8v88nxR6TrcYtcQOxGNi2itYl+7CxqXXDRCJx43FRP7933koehD+kaSJcA4tSK2+
	 v1x6MAykffOCSc4sk6y7oGyf07QFPrWuaC7oBxB+53jId/iZqqRo/sL3p+kb6+s3lTR+C
	 jSeHQ6RiSqJ0U43pyLL6zVoQGmQynEfYSI50OvzKcfu1lq2e6atjyo4V4UDR4xnVIuiWN
	 q5zqZ5NMNoBARQyaIo7Oji3K17RiMZar1Grkp60i6r97FWvU7V5uOYqiZ3ZXtlW6kB/Oi
	 1apXW0RU8gf3EKc4PiEuXh5prUjxEWqRIQjHXUW8WU7p10teyEtHZq2WYEqBQHxsbjg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=juMN8x4b;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BDF2606A31C;
	Tue, 10 Nov 2026 14:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=juMN8x4b
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=90.182.112.124
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794320278;
	b=AX6SZpWCLnUiQkXqK4X2KlUeaN7A8fyGX/6VO3jyPinqPVLeruzdYhwc8Wp7eip4Ci0M
	 O6mY/i9VRcVNlM9LtMK0wWm1moVINJ5/2LlGhCK3td14rnnpr2cWz+ZWH5g1J1A4flCdF
	 zLhYo4B24n8sM+zt3na5tU+GmPbPE4Xg0Hq7DcC0aQJ1DKHlR8yomeXzX527cQxe20uGp
	 cQIB791nlSZ9IewTWwLs7FCr7++QDXVuL/TZwFEhj75Lgr3igteenJMcXShsvuDwHMV0K
	 6yHeQYoLXT6JbF0UCc8eYqzeo2Tj3g4xYsKN0lugNEaQ8WpwoYAE3vcGA6ezwTkYBXA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794320278;
	h=DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=m9cQN4Mf0HNTTXs9cCLTRamxoxvLO8N57TLPiFrWzX8=;
	b=YXUrvbZ5KvAbrDzkcq39ZxuHvPs8syJ/sQ/5WPUJ8EYxPSe1pXYNTRA/v5OH/jLgUGnK
	 XGMN1WOkk62lZx/xrStfhp/1xYtXK74YG2r4qjXeOUBr08pS9oKqlbZaBrv0edFoYMAZw
	 F+kHpTgUWWowIqqaJZVX7nh8+Ey5yCuhFzyUcfNA8Y0AoM/D6EbK7ysCgwYh/xuvbT/Vr
	 zWcUZtaxEwFDCMp5bGU0VSccl2qKo8iEUxpgC17UcLjrwkwVb7SobKPEC6uKWEwS6TSWi
	 A5zZKKkJMLp1n1h1qAE6v/BH0MXUy6HgLj0P2Aag2sjoQh5pG20hLML+DJHV6OGrzpQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=90.182.112.124
Received: from localhost (90-182-112-124.rcp.o2.cz [90.182.112.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPSA id DA2591F0089F;
	Tue, 10 Nov 2026 14:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794320277;
	bh=m9cQN4Mf0HNTTXs9cCLTRamxoxvLO8N57TLPiFrWzX8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=juMN8x4bvCrGZXtwdC4hPdomY9HNv6NJfQvZBY8ZKCSKsEyC4dQ1ft/v/31rfubLS
	 q5zESKor7iHwbbb9fM5rW5qGC9ZM3zP69xXlNuEStwpCBP2yDyotk2MBq28UEStAyX
	 zUvjrWWr3Ef/VNnoYFyXYzaYpLpKKUl/nj7I/c1WqCJKOZK3ZEefh9Wrf/GzgPV6Ql
	 U+r0NRTzCXrxuSFW7+2bGivK1U3phApESe6ZZcgFqfCvdG7kWY0yDBN7bYUqgAq9oG
	 kRpm9SzFJVeiymfaT7YLoXP3sNVP3147PFn8u1sGYdtjV/ssBQgFYKkAmFmtfD1WaL
	 dS9pvdegMUXwQ==
Date: Tue, 10 Nov 2026 15:17:51 +0100
From: Joshua Crofts <crofts@kernel.org>
To: Nick <nick21042013@gmail.com>
Cc: gregkh@linuxfoundation.org, jic23@kernel.org, lars@metafoo.de,
 linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re:
Message-ID: <20261110151751.0000582f@kernel.org>
In-Reply-To: <20261110140354.2047-1-nick21042013@gmail.com>
References: <20261110140354.2047-1-nick21042013@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
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

Hi Nick,

Several issues with this patch unfortunately :(

On Tue, 10 Nov 2026 20:33:54 +0630
Nick <nick21042013@gmail.com> wrote:

> From: Nick <nick21042013@gmail.com>
> 
> Date: Tue, 10 Nov 2026 19:57:26 +0630
> 
> Subject: [PATCH] staging: iio: adt7316: fix camelCase violations

This shouldn't be in the body of the commit. Additionally, you're missing a
subject.
> 
> 
> Rename Vref and AIN to lowercase characters.
> 

What's going on with the spacing? This unfortunately fails to apply, as
the patch is malformed. I see that you sent it with git send-email, but
was the patch created correctly with git format-patch?

> This fixes the style violations and brings
> 
> the driver into line with the kernel style
> 
> guidelines.
> 

Additionally, the camelCase is intentional, as this is standard
notation for things like voltages.

> 
> Signed-off-by: Nick <nick21042013@gmail.com>

Also, we need a full name in the Signed-off-by tag.

-- 
Kind regards,
Joshua Crofts
