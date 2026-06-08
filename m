Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7433655FC
	for <linux-iio@vger.kernel.org>; Mon,  8 Jun 2026 12:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780921190; cv=none; b=hWS/x388bwWh9EwGsNZKmI+AGFgOfyDYExR0dGuM2KrWdPTTrBXabak+vfjKdB6LQwR/rC+u4ti119tmGtWvle3HQnhZzh3hwvbWp4YryuUBUwieMvRFbrnmny4FTicR/SBiCYOVYQua8y5AVhBHTWM61td14IMsLWpDXHEO75E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780921190; c=relaxed/simple;
	bh=e1bzxx0iY67CI2xUqgdhPs4ZiUlAksJ9p2jPa6KR9Ts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ThGXsQTIw8YwRNulnAxDmEcgl8VLgbyOWTNEOALLtuIfKS2kDFpyj3lvm5NAiLUsaONigQkCdXQM9L68XvdJuEf3ivloGQZE5GSe38klZ+fF2BH+dkYqyqVt6o77AeXLoYfFAC9b1mdSDhWQYjidarouwai1xRDODCKS94bf78s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f6BuzTUR; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f6BuzTUR"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-68d232ed3f9so6783328a12.0
        for <linux-iio@vger.kernel.org>; Mon, 08 Jun 2026 05:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780921188; x=1781525988; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e1bzxx0iY67CI2xUqgdhPs4ZiUlAksJ9p2jPa6KR9Ts=;
        b=f6BuzTUR0Vo1nNXTlVsea4CYnx+Bnk3dYUWA68JSkalbCa6VuPfPKeMJUwFuKpH7Jg
         nkYWcdel04pkIbK11FF/0vHi2s3ufb9SHlWteZKLe96BN66LArX92XrFqwNd4PnUZjcO
         k9Xzx/NIuEZCsiE3Alh5bEVrOJiDNuhuYrpw0MO+IfN3s8MDLkOdxqPhUpw7rti25+cn
         DjWvYs/JCCvyvlgu0fsbpTDys+uRdRJy5UYRw0lTSHeMdoy61yFIlP6R0q6cYlTey3/t
         PAb5Rkk5mQ58snUnwh4C/+lvX4Yz5N/tFDHzzK4BkwyIl1VaFsX7mjmaInucKyqm4S4e
         z47Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780921188; x=1781525988;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=e1bzxx0iY67CI2xUqgdhPs4ZiUlAksJ9p2jPa6KR9Ts=;
        b=n4j8QGyMOMif9K0WgS6+LZb7tECjEsKtL+clXvHpMQxdCcpZyNWsp996fahy5x1aWU
         ia/Gn3fzN0EdOCqK9v50fWe8bYapJyhqiwUfmjMmUXRI1+cEPG4fmA2/+WoEqQsZ2CbY
         aVEBAKUXt7GwD0EemeExJCZWf/H2Ka1TQQR2pH+u5stecBQQQTpbISecn2P4hc2ofIPh
         wpIF/ybWl1fhzoR+xOk9Q1mgilip1DKhYZ0Mr2YVzwdFzpC4z1PcD5IOV+RyfabDsr7N
         K9+v18uauUlq6AqCD/MUgjvOWiDITT8/OnvRiaS2FspfxczYjUWf2wx7QqlWuJ0ruGdq
         MKLw==
X-Forwarded-Encrypted: i=1; AFNElJ80uXGMfGNQQG5prfozewRsgFN/n+zSXUhEbGmYmhJL/W5U86hPkoSt0T+yUPLX0KSNXpC8GIlyEiw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjLkTREZkb2IHvRam5F5mb79G6oNtRecakbEe0nTbeVAeck6gM
	rELmGMxLZNfs36TfkBJQ1AbEi3I1enWpwCpcQCiyEnyxxjczdmCmiEmn
X-Gm-Gg: Acq92OGINHaY2dYc6LS8eIBeGM4iE2DzOqYuSEvVln/IqqhqlltQkyTOs7aUx1mkIQp
	KpyCHnBTsPTxZNjduTl9eoPm6xTNb7RCVmB9Ma/HmlHhFiWVwKD/S9rTDSqF6oKMQNHG+YuCUcx
	wNSMh2jC1BSlN95BxAUgouug8wcc2sEezSn13Vjh++v/qg8vousi1uyM3VqUGgGmI8LizGBGNJW
	NJNmDDInLnkGrUoJ7IK8TIBGKRRG51DnM9g33/jcFSJvpj+djDCRk1i8kvLWjTgjhbdTXTp4c7L
	pEKsoU+F+4PYXw8ev90Ta1hvhPPX70HHxsozG3h6kj0k4Ck7zmxL8B+sVaAIyt/2YxyxTfBBn4n
	02xsyP3o5FOWtN4B7hHkRB6o0IMFN7y2H5Er/cwtL15ZTQBjknncZuBoziZ+4MCrfmLeM1DSYbE
	pHzVyp1QX16cC4jals8OpahwFSDENqdsvbFqbilKGgUBjT9DtmMt8xbNRnFQLCPs3uY5DKI1NdL
	0Aj
X-Received: by 2002:a05:6402:1906:b0:691:5700:7d34 with SMTP id 4fb4d7f45d1cf-69157008526mr4271194a12.15.1780921187287;
        Mon, 08 Jun 2026 05:19:47 -0700 (PDT)
Received: from fedora.clients.cmblu.de (p5df027fc.dip0.t-ipconnect.de. [93.240.39.252])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-68e65b57c66sm7017671a12.28.2026.06.08.05.19.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 05:19:46 -0700 (PDT)
From: Wadim Mueller <wafgo01@gmail.com>
To: William Breathitt Gray <wbg@kernel.org>
Cc: Wadim Mueller <wafgo01@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/3] counter: add GPIO-based counter driver
Date: Mon,  8 Jun 2026 14:19:32 +0200
Message-ID: <20260608-gpio-counter-v5-ping-wafgo01@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260524193846.19216-1-wafgo01@gmail.com>
References: <20260515153616.157605-1-wafgo01@gmail.com> <20260524193846.19216-1-wafgo01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sun, 24 May 2026 21:38:43 +0200
Wadim Mueller <wafgo01@gmail.com> wrote:

> Add a binding for a generic GPIO-based counter.

Hi William,

gentle ping on v5 - it should address all your v4 feedback, and Conor has
acked the binding [1]. Anything still open?

Thanks,
Wadim

[1] https://lore.kernel.org/all/20260525-register-bogus-b198545b69a8@spud/
