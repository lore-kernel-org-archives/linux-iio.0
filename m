Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4CFC3644BE
	for <linux-iio@vger.kernel.org>; Mon,  4 May 2026 10:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777890565; cv=none; b=lg9ohUPW0+zwrZszxC0sv+kVCC/GhxmJo8rveXXL9P/SMD82Hqe4lp9dx10gBqCMHhIkNgUt6DSOQOxwURO4aKkLZygdnFGebmntOEXtqRm/JRIjybY9YFA1/SBzPuKtFGiyEcszp8q84fuqCDA85F9515J5dPh8KwGuEO0gVng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777890565; c=relaxed/simple;
	bh=Tl3VqM3hywY1r3QXa3Yprs6iZB9aAkfeNQRo5hC43UA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=euPhgJySg4i4LK8Z3WsJk6BWp1FUhEbRUBAD1dicL7cf49HTH2oRYYXQUoF42HDSS7DtI+TgVf/wZLcfWAe9X+uhyJB3kyCEHM/vXwaQg0E5Go5JJeMoeIuCx7EKOqlTCW6s/TmcxmCOFE20y/jcOUbyVsedVNi7NJt9OtGICbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cmY2y3Wg; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cmY2y3Wg"
Message-ID: <5f126a59-9f03-44e3-b4cd-27f70bd9840b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777890552;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/JdBfm5/FeCpkOwuefe6HGDXxCL2lAQQbrnIFT01dTg=;
	b=cmY2y3WgXily0aTB6Cx05zGLsCDiTGEhAASXVI7NvaM/fULjpb0XiNUtlSSHcH6NdgTp+s
	KRMMwxbtva2BSSlajV6/tzQ95QoxjrlW3dGcaljp5/gstLMRKLow84ZI7rQstpHLpOdGtU
	6GWeNlzwzxWuhwUyh0kl5CZ3ZE87cog=
Date: Mon, 4 May 2026 11:29:05 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH v2 1/4] i2c: rust: add smbus_read_byte_data and
 smbus_read_word_data
To: Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>, jic23@kernel.org,
 linux-iio@vger.kernel.org, rust-for-linux@vger.kernel.org,
 devicetree@vger.kernel.org
Cc: branstj@gmail.com, lars@metafoo.de, ojeda@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, igor.korotin.linux@gmail.com,
 linux-kernel@vger.kernel.org
References: <20260429132234.30514-1-muchamadcoirulanwar@gmail.com>
 <20260429132234.30514-2-muchamadcoirulanwar@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Igor Korotin <igor.korotin@linux.dev>
In-Reply-To: <20260429132234.30514-2-muchamadcoirulanwar@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hello Muchamad

On 4/29/2026 2:22 PM, Muchamad Coirul Anwar wrote:
> Signed-off-by: Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>
> ---
>   rust/kernel/i2c.rs | 24 ++++++++++++++++++++++++
>   1 file changed, 24 insertions(+)
> 
> diff --git a/rust/kernel/i2c.rs b/rust/kernel/i2c.rs
> index 7b908f0c5a58..6eaea1158fda 100644
> --- a/rust/kernel/i2c.rs
> +++ b/rust/kernel/i2c.rs
> @@ -477,6 +477,30 @@ impl<Ctx: device::DeviceContext> I2cClient<Ctx> {
>       fn as_raw(&self) -> *mut bindings::i2c_client {
>           self.0.get()
>       }
> +
> +    /// Reads a single byte from a register via SMBus.
> +    pub fn smbus_read_byte_data(&self, reg: u8) -> Result<u8> {
> +        // SAFETY: `self.as_raw()` is a valid pointer to a `struct i2c_client`
> +        // by the type invariant of `I2cClient`.
> +        let ret = unsafe { bindings::i2c_smbus_read_byte_data(self.as_raw(), reg) };
> +        if ret < 0 {
> +            Err(Error::from_errno(ret))
> +        } else {
> +            Ok(ret as u8)
> +        }
> +    }
> +
> +    /// Reads a 16-bit word from a register via SMBus.
> +    pub fn smbus_read_word_data(&self, reg: u8) -> Result<u16> {
> +        // SAFETY: `self.as_raw()` is a valid pointer to a `struct i2c_client`
> +        // by the type invariant of `I2cClient`.
> +        let ret = unsafe { bindings::i2c_smbus_read_word_data(self.as_raw(), reg) };
> +        if ret < 0 {
> +            Err(Error::from_errno(ret))
> +        } else {
> +            Ok(ret as u16)
> +        }
> +    }
>   }
>   
>   // SAFETY: `I2cClient` is a transparent wrapper of `struct i2c_client`.

Thanks for the patch. However, we've previously agreed [1] that 
I2cClient should implement the IO trait [2] rather than adding 
standalone methods like these. This patch would need to be reworked in 
that direction.

If you'd like to take that on, feel free to submit a patch series 
implementing the IO trait instead.

Cheers
Igor

[1] 
https://lore.kernel.org/rust-for-linux/20260131-i2c-adapter-v1-4-5a436e34cd1a@gmail.com/

[2] 
https://git.kernel.org/pub/scm/linux/kernel/git/driver-core/driver-core.git/commit/?h=driver-core-testing&id=121d87b28e1d9061d3aaa156c43a627d3cb5e620
