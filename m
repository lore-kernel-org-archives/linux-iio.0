Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795570848;
	b=mBl3+B4Jz3fB0GYA8eR/6E0GDPyRGiJX+3VZ8gmE/Ajin/MbcoAJvD8r9XaXJ4qZBcny
	 HUTF869S2EuaGadXkQqoIzVILs+6Yoxpv3e1ah8y/WyaFnEmKiX1vsditQQhp7Jt4kBQa
	 YNLBK1c+kppIMFffArt6QQ9ZB3+nUrpS12MlVexf1f41Yt2m9IcWLTve9IQc74JRBcLyh
	 Q65lLFEVhOE8k3wiGVopQj5THNvN//nyKsrfqt83g4MGNSJq+3EF7N7fsSYID3LO0jEkX
	 L8H7qFmE6yB/RzarmhQZqDgy3xMFG+0ZZ4NwOBCssoe+APytjYqoCUrZnivwEZ4pWcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795570848;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:References:
	 Content-Language:Cc:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=lMn+79+xRTKct7sDQLtayoqfdZDNWSUiec9/f2ZPH6M=;
	b=E9xzvkhHDprc2HSsBUGlh65khGl6c4XKF6zdeyknmQoK5FemQ63pwdxf5XuyIXlL02aP
	 G4cf4z52ZmSETn0hw8zgPXeKp4x0oEDENnMlAzKVhD2LeNkuit7jHs6oYJGb7QMnN8w08
	 jv4MXe01XLckypS79FosMX6K2LwMHGwgEq+DeJg7A9y3h1KDVc7C4L+2L7Bz7/JaU8cBF
	 eQFZHgzIYynAq180sy9lWLorC478rEjXho3CKxQfnwyRrMrkTrOjOccGRNnes8cSSg+VD
	 pRgZYeK/WtceUbT7yz+oXlXvMhz67/M9LNT67k9UAfh0reU+gdzcKCws7knPzZ20jsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aKLVcUCW;
	arc=none smtp.remote-ip=209.85.216.43
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73CE9606A323
	for <linux-iio@vger.kernel.org>; Wed, 25 Nov 2026 01:40:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 73CE9606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aKLVcUCW
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3b413d04c93so3020900a91.1
        for <linux-iio@vger.kernel.org>; Tue, 24 Nov 2026 17:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795570848; x=1796175648; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:cc
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lMn+79+xRTKct7sDQLtayoqfdZDNWSUiec9/f2ZPH6M=;
        b=aKLVcUCWjaGLEkL7rE62+5x2NfqZS8rT3GrXE1OUuvzR1jZo08MDOJR+8g7o05HVVv
         BPS1pp+bDADkiU6vd90PrPz0d8dlGkasYu+Li/MHmAmtoIIwkGKfIf0fYOHnFZFEPMx7
         jh9rKU3tyg4MXVP1vd/WfX+vAaYthqeW0uPPFBMrCsoIylEi9WHbFVx/KgAM9ksOCs2g
         Uc9VMXtYMqqrUSM7cO6VY0Ny6z9WH9fyAfVJO4ZCY3egMNBChA0EEwZKwbKUaAnJ919E
         9AL9yCJWYjp33eRSEFPeNmvGf+Dhy5/3IlJ9zIaGNz/tj4G8aQQm3KY7TVxsUImztWbq
         7aOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795570848; x=1796175648;
        h=content-transfer-encoding:content-type:in-reply-to:from:cc
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lMn+79+xRTKct7sDQLtayoqfdZDNWSUiec9/f2ZPH6M=;
        b=rcTBMjAV+kt83pqoFaXVR5CjSgWFALJ/nU6eJRKQAWetEeRfDptTCimd5uxbQYrMaj
         zud/cRnunnj5rZmiR7pKJC4S/a51MrWDaZNilkO4+WuOWFYhlVAavJXRp+8OOi6f04OG
         q0lS+RKBeo9YLk1jAuIZllpJLtF6Ci7oVVy7Ptl8VajwJuQw04rXYOR+DfhTD4TAk/1h
         l3gAzB23XJwIl4syQphJ1a5cKlvG6feysIB+LUQF8XPl65OTdIs9nBW4LRA5NGrM5eno
         Lzp83NZ7BaIHDStRLYF8sE9RWJV96NR0zkt7uTkvp168RCd7RGMQX7gjeLokvCL57bzu
         4avQ==
X-Forwarded-Encrypted: i=1; AL+hErHjHMo7DKLHPtMerZhsD0Vm76ydDIHfYZXZxmh4ixhzc9q8zK4awE61zn7IB0m3N+KYBwIFmKmQEoA=@vger.kernel.org
X-Gm-Message-State: APuU4Z/DzuXadz48bhCmb/mQb+W68nwEdqrqM5nGvSTfvcNuvodhAqWG
	CtNA1fUQdsyT0P4Rhqw1qu1eHAuefUYSmROzcDUju2iUHVRFWAJLg9Yh
X-Gm-Gg: AZFdTZf/aDGlV1NXTrNYwWT99eVm+j9q05ynIhWJ9DmNStD439ZpWsCTmr3NhmFjO7p
	mFe+LsoaX533kfeYuwTmUS0Q/iwqlVDXJqFuvni0mnlxdn/Mxc3VgYJNl9n7Xmd0TANempkFUde
	mkzyoxmbqkRLrvwU084kWO8Fw0FnfcEfPQJsdCOLf7ywuVpdXOyEurPEhV2JRQUeNtMizjLUru7
	GadqFBghKiF/e51dkYGhw1NIAGAaEqjUwkPvLkFgFskgb4BEIhefwLE4QItIeTClj0S+O1S+SkA
	qtm8KRr6R6LYaFWC0mjbuhJa8FZyILWEd++BIxTyblctCSOMdeBchRIgLhRdO3pxDg47Nwx8dPk
	J2MYwvTddWY8Ip+Val/CRDpIZzYPXWLrcSPbw+632PwvWZjihILeWn0DiuGQeRtm9hPjkWAwEnH
	DUqA6YrC6lL4MplzHQjLlcoJeXS8OARdCdk+x0qSBknu3bkMBMG9fqCkDL8w1h5fO2Cm+tE2lJo
	t6IjO/tz9MiUD3d/gjS6pEDuted1nzFNy6rQvvTjN02dPOlhEzTepL1GOUD+bLroH00VoQap/yw
	be3OUfAjwvBdUoAZsZkSzR8ScS+UOFuD/JlIH+aywppS1p+djCaJUNx9dBkHk2sPhGXK8X+x9w5
	AyDu1
X-Received: by 2002:a17:90b:4acc:b0:3ad:ce34:f63c with SMTP id 98e67ed59e1d1-3b41c9e4b1amr15908819a91.30.1795570847756;
        Tue, 24 Nov 2026 17:40:47 -0800 (PST)
Received: from [172.19.1.42] (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b4b3c71192sm8761791a91.5.2026.11.24.17.40.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2026 17:40:47 -0800 (PST)
Message-ID: <8c25cc7f-5c8f-4bb7-b82f-0f2d1933e334@gmail.com>
Date: Wed, 25 Nov 2026 09:40:43 +0800
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/3] dt-bindings: iio: adc: Add Nuvoton MA35D1 EADC
To: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>
References: <20261117082832.1551574-1-cwweng.linux@gmail.com>
 <20261117082832.1551574-3-cwweng.linux@gmail.com>
 <sashiko-outbox-218423@kernel.org>
Content-Language: en-US
Cc: krzk+dt@kernel.org, conor+dt@kernel.org, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org,
 Victor Chernyakin <chernyakin.victor.j@outlook.com>,
 linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, cwweng@nuvoton.com
From: Chi-Wen Weng <cwweng.linux@gmail.com>
In-Reply-To: <sashiko-outbox-218423@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jonathan, Rob,

Following Jonathan's earlier comment and the Sashiko review about the 
internal VBAT channel, I'd like to clarify the intended IIO channel 
numbering.

The current driver only supports external channels 0-7. The internal 
VBAT input is not supported yet and does not require a DT child node.

Would it make sense to reserve IIO channel specifier 8 for VBAT in the 
binding, while keeping #io-channel-cells = <1>?

External channel specifiers 0-7 would continue to refer to the 
corresponding child node reg values. VBAT would use specifier 8 without 
a child node once driver support is added.

The current binding also requires at least one external channel child 
node, so a VBAT-only configuration would remain unsupported for now.

Would you prefer to document the reserved VBAT specifier in v6, or leave 
the binding unchanged until VBAT support is implemented?

Thanks,
Chi-Wen

