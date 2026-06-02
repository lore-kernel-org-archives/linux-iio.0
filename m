Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4541D3AEB2D
	for <linux-iio@vger.kernel.org>; Tue,  2 Jun 2026 08:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780387888; cv=pass; b=AGVRAWpWWNzUWFrblB750gIeI80wbWWj4l1L/HxqeE3THqScEYPJ9IRps3DncBw2snKO21faGDT9AXGOx8nytYCW3w8WiAUI51lVtm7pfGnOv0tWbz8qF+BlEk7WEjqpDW2o4WXMbx6NnQ+yHEm2R846ZoiaLU9PuvhjDUdd4X8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780387888; c=relaxed/simple;
	bh=pnwmlQxuqdNrQurh7v1e9vKSMxYrp0Jp3doNPYkrr1U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QuiAK+gjPYawi28uiDuyvs2b8IFQD0lyiZ/uDPxdO+75zf3zrTDqrDJr8QF5Qn19nslnKXmzDo2adKDCibiBIQCUhMIYRGXavfenS3e9n32X/vopPKUz0T+FozKgRnzky14W26HeBFtEMLJwuAf0MCSs3A9aoA/B/jXGQVXqqjo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gSrTIaqe; arc=pass smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gSrTIaqe"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5aa5edf347eso2491550e87.3
        for <linux-iio@vger.kernel.org>; Tue, 02 Jun 2026 01:11:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780387885; cv=none;
        d=google.com; s=arc-20240605;
        b=hNbjTdP9y+2nddQw7RNTYjy1D/hdbbLPCppe1fVYW+FZ/Ypv3NMVAVtsRfGR1vMJAL
         2exLl8YGvbLE29Gql7JRTworL5jfTtwO70IYvqYzEQvOy/N0U1h2IWXBqKfG1GHRJ1kA
         Bg00kJhXoMYG0+4v3mx6Z9NpKl4S6dP3KH4gx3WsnFF8yn4Ie5xzNleoD0xzmlaX65F+
         64wN5YH7YSOF6dRAjirOPzUfBiLRjZrc89vNtSo+n7hvY3JrNr2ZfgujufH4u7JxocJ4
         7YHEC4ptnWZoGVMdmB+4gy4jOo784EtHQkPlBkdtr38MUQrVYprd/pU313+4ss0ZGZzV
         KXZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=0AqyNY/g3TIszlVcbBsHINX2o3fZo7a95+GAaAZfEE4=;
        fh=7jj8BKy16E1WF24AEfbtUhzBmYip7aTr2fvaTtzrN+8=;
        b=ignUxukj/9FbU0MC1Ov2A1BYnF/eeBCdVdfeF9DlfEnFPUDpZEP1rAZYKcvI0Sv890
         1iqU/t0y7E6o8Q5wu56QeUt/2nYlJmgNnG9tvjkYfCEsMZKj5p/+PaPA+drQPEL2JSJN
         jQTKTbVN7CwwVWq0Q2S3UasiODXGDJs59rUjlzz0M+xED8q8+wjDsDivgDR9FRpjfbUO
         wYdaQwwfH29kLy3aSf/5AvwvZXpDMVzui/7iDuJKujgKCE5kvYkp6eBoyVJsHn/gVpI0
         LKwxyZQh/5Ym+EMTZCBbak6ez4twhtEG8lxazREyd+3cQcf0jJM1Rc6uZ9jD1g+/dRnG
         3QEQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780387885; x=1780992685; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0AqyNY/g3TIszlVcbBsHINX2o3fZo7a95+GAaAZfEE4=;
        b=gSrTIaqe8y4APNvrrEF9dpDWnvgf+dXoj40XvtK53tn76AhXRONto3nvO+Z0Q9Bq12
         kWcxtEgncTVBB31sB4OO7Kx19+Kx65xCNBs6k9xIyo3TEjj0XAfWyec+tyaROZ0XQIME
         QOCXojv65TwcDQ99IMOMP8rVpHS54BIvOt7P0c+pTaphRvZM4dsUbprC+IAwmgf3/5oG
         knOUDGVBVFWH00emlyVZuF+uWeZU132AINezOJD4CLMVpPujY6ZGdefK+wWuGbDt6M9v
         pKFRGsHrlt8uzqUwxJ7oklJWnFM/20ib8QC4X22OLsAhyPIAgqvasRZxE/ZqjM7zxMSr
         7pvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780387885; x=1780992685;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0AqyNY/g3TIszlVcbBsHINX2o3fZo7a95+GAaAZfEE4=;
        b=epVU02F0M40NLgrAKxewCd2xv+PX9HSbEb3YlhSVKQw41XEthKGR2Hhfaw/SVFm2HV
         lZdBnevbIEWOaF82Tlgg0F9oJJlAQwDwsNHzOG/9M7tHmWrlrG0P0QkN7bnrZXeicrcB
         LdRrXjF611H5RwCSUtGLxcE8Kiz+qnVkZKJuZBctBiUXg0Ds+fBeioCb+bwP1JRFY481
         tihb7zbAPqCSnpFsCMb5m+xnOHnFdc203cxWF0y+fHT6X2ZK7WiGOQLAL3T9SFOs7XBY
         /CD9jpotT7YU7dGFwaJBoEiRpOwclDj89QTILZHHzIRIE4xainmZklpaejAC/1sVVdhC
         nfVA==
X-Gm-Message-State: AOJu0YzfaTM2uF92Gk04pnpzHuGOB90x887eVWp4p5kfDWBeKjBEItax
	yrI8CDkSyRWjkfvMXRLzXObCd4RrHYPBOhfdvbqX0Pedr86+ZP0B1oDPiEBHm/QzkFTj7YfsWsj
	3aJY15dgFLO1yTtUHFiLi3lTZsTSsabQ=
X-Gm-Gg: Acq92OEri7W+qKjsIqI4H/uIe+S2eMW8MpTNTOU5f/z/yIPytJLC+Y5gFd/SJYjSCT0
	+YXAki+1WVcv24d4sYoQwk8dWv9iNDO9ly1LZiYcGjwWlxxDxHii/oxNClkThJb/By8lkBC8qhN
	6+WUVJLfyj8TnhVfjX/+ECYEOhMv8KbXW1xL7MfojQAiEEI1vL7qqtuIKWFFYR34K0KyzPxTSP1
	F02+nx9EoZNCpQFw0xVlPdM9K77mMLp7Rw1y5dHkOq39eXEv91U2VVram2M2RytJ5WifevVl0ZI
	dyPd45nIpLDqOCmVFgPH
X-Received: by 2002:a05:6512:3b99:b0:5aa:6523:22b5 with SMTP id
 2adb3069b0e04-5aa652323acmr4015131e87.16.1780387885222; Tue, 02 Jun 2026
 01:11:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260524132824.54918-1-muchamadcoirulanwar@gmail.com>
 <20260524132824.54918-2-muchamadcoirulanwar@gmail.com> <20260528162557.2b0b28d9@jic23-huawei>
 <CAO26r3QZyVco2aZRqPSyWr3d-SBAVEknkaeNDM4g5DFCr3-2aw@mail.gmail.com> <20260601100559.274d5b05@jic23-huawei>
In-Reply-To: <20260601100559.274d5b05@jic23-huawei>
From: Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>
Date: Tue, 2 Jun 2026 15:11:12 +0700
X-Gm-Features: AVHnY4Irm78_Kg_xuJgPzY0YzVzov3ndwWZWvfzeJyil_0GTKGZCNCjHaprgtCs
Message-ID: <CAO26r3QLJ1ZR1Qfjr6wQo+e3H6v=Z=bxkeE8+nseajYgWLbi4g@mail.gmail.com>
Subject: Re: [RFC PATCH v3 1/4] i2c: rust: implement kernel::io::Io trait for I2cClient
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, 
	Igor Korotin <igor.korotin.linux@gmail.com>, Brandon Saint-John <branstj@gmail.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-i2c@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 1 Jun 2026 10:05:00 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> +CC linux-i2c and Wolfram - make sure to keep them on future versions
> of this patch.

Noted.

> If this was renamed to make it the rust smbus binding then I wouldn't
> be as bothered by this. For something claiming to be I2C this is a
> misleading interface and I am very much against it.

Agreed. I'll rename it to make it clearly SMBus-scoped in v4.

> Understood that there is more to do, but given the regmap already
> encapsulates the smbus support you have here, I'd be much more in
> favour of the focus going on getting that done.
>
> I would almost suggest not merging a non regmap interface for what you
> cover here, except we do get annoying corner cases where the device
> uses a mixture of smbus like commands and non smbus so there probably
> will need to be support at the i2c / smbus level.

Makes sense. Will defer to Wolfram and the i2c folks on whether this
should wait for regmap or land as a clearly-scoped SMBus patch.


> Is this separating a safety argument from a bug check? If so why
> not just use the tighter one?

> +    fn maxsize(&self) -> usize {
> +        256
> +    }

The try_read8 here is a general SMBus wrapper, not AS5600-specific.
The u8 command (register address) applies to any SMBus device, so
8-bit is the protocol max. If we tighten below that, it breaks devices
with registers at 0x80 and above. The 7-bit limit applies to the
device address, not this command byte.

Thanks,
Coirul
