Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64678217659
	for <linux-iio@vger.kernel.org>; Mon,  9 Mar 2026 22:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773096930; cv=none; b=getDXcK4jFQs6VlGipKVtR2mbDBi4Ir8UdIdHPU4ZMjbTexdG9Q6Q1lDUppJcenqwfmVmDPANLtSOmep9yphGDcjNGn10bUL0LII0yYTv/P8Hazs3xMK5a8fiTx/DZwmYGW06sxcgtoivLPej6D8seDNTIasPFARHxIs7M9mkZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773096930; c=relaxed/simple;
	bh=DBIdLq2Z3J4VeotgqKb19V9ckuzhD4yEV+jQWQ3HIqs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EAfN5dtvV0Z7MxOUdO0lkp3RawG5hhsSrMzOhPujP03OPWeQnSlRTIwwhppk2AxbIOi84dMTYbfMC7w6rQQ94hGwP6Bz8UoV0RKeJg6mGhjXYzBzdUApORxVyTF7EtN5XzU8X7mLIyoR6VARnUdyXp734lzKzlBtDFGXaEvqMf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NYPD/CW/; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NYPD/CW/"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4852b81c73aso23479705e9.3
        for <linux-iio@vger.kernel.org>; Mon, 09 Mar 2026 15:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773096928; x=1773701728; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cKhFKPFiQuwWyogCXJd8yvOA0rQ+ZgaRfo63gB0wI6c=;
        b=NYPD/CW/x9kWHs5OLWfrBulkJKgzp4lWaA+WJu2vBQD9cvG18Wg5P0cithaBoMaPQG
         66DOkV4vk49aohn+TUx1Tvj2Bt4RhxRAkX/vGL3DfXRQFo/aLJxgSg8qKgCVBbCi6uOg
         kKN0C5kB7OgszNo9xtIhMQP42pyNJE0NyMQqFZK5WCkoXO6aq094q2BZaKePOuW2UOsn
         O9K8ghIcOlsaa5G0hjdWG4A7vH9fRRTF522feVRrE6YErFcpWU4teClqLxGrn/giD1ky
         OSGNSitJG0c9plwP0I/TzL2km6ns1xwhtU9so3qU5cjw1Zaie4TdXVJmtibIhK9yltcm
         iRog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773096928; x=1773701728;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cKhFKPFiQuwWyogCXJd8yvOA0rQ+ZgaRfo63gB0wI6c=;
        b=un/0Ek96+FSHOkFwpO25GZlQWreQrjohdolnLCyTlJmNdeJ+GzhC6wfoCF5DsAP2dk
         avbCOt/ed7IArbWhl7X02xhoFBBUG95yzZDvYiztz3taAiQXCtYoJITUI6PNMhsVL5oQ
         xrHXXUSJIk1ipNtd3jViq48qv86sHorksOgfJhLxobCgrSWwR/l4vtHkV3M2FtwTUfEz
         xlxn3suriAOjSa1jB/fb9xfjY8/oFqZiB1yjc8bymBrnV3OPD1blHyc4rb6FOtE1+78Y
         Ci3dm4iryStCG2m9/5Hsg5OoUZYIRdylJLJTn2uriVl12gKQNxdLI+o9Jh2SsL+WLSyd
         P1oQ==
X-Forwarded-Encrypted: i=1; AJvYcCUd4o30QLNQpyujW/mlV0hnGDZnC2PaVYE5aFsFjLs+ZobbfIdvpa5atzMD7pwH2TBbgnB2ZS+H5Lo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKgo5kIHXfX5THLSZYVMloWGgXYISHgRvlFM9+Xl/EMdd+9+9n
	3CLqq9mHUc88II3bkcSJ6OymKcE/iedXcCa4bNdC0OTrT4nn3m+n0XCn
X-Gm-Gg: ATEYQzx3v9M4kVyQLJG3QWFNjYxFB5byOrLVBZ1Q0k2rtpElNZw5WAhcr6teXRYICe1
	JGDK24RNPqkH9q39Bb5x1GIfx7k4lF2QkAwgNv4hPH6rAR96tJU3aofyko1cAADd7ZCN58e3yje
	SMtgFuPM2ikLXWQijqZkyrav+teoUO+XxWvdPXxmw43r3lESBgpxcxk822QH7WZ6cn0mqSHk+Td
	I6rrOSdJCq/Noapbrffx1tMlBFZ/NSJ72EjYrZdt6TpuVY4LUsQoC/rOV69BkgbH3lpAd8U/IY1
	5bJ4DtIODbl8Nn3b3Z9+YtoHrsunn/G6itW/YTjnVCwGrwaZGzHSDJ264f+0RltD6TogzcRHXp0
	iiJ5D8ePRBM4mblt6z6iGyrjO644LuEGBjvY4JikZ00kKRIwwY5GCUe5r3/vwEsDjWRomQ3KuOD
	xsavNXVGHBqG5DLL5o70Bnscr2KdmY664Qr3TsrDurvC0Nw8f8Xwg9+JuEyY+6Le0GJVFb4HvH7
	41e+qt3cPhBsdFz1Q==
X-Received: by 2002:a05:600c:8284:b0:485:39d1:b4f5 with SMTP id 5b1f17b1804b1-48539d1bb46mr92795595e9.17.1773096927410;
        Mon, 09 Mar 2026 15:55:27 -0700 (PDT)
Received: from [192.168.68.113] (192-164-23-214.hdsl.highway.telekom.at. [192.164.23.214])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4853a797dbasm56502355e9.7.2026.03.09.15.55.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Mar 2026 15:55:26 -0700 (PDT)
Message-ID: <ebb8bcb5-660c-409c-89b1-d473ba5140d3@gmail.com>
Date: Mon, 9 Mar 2026 23:55:25 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Request for guidence
To: ShiHao <i.shihao.999@gmail.com>, marcelo.schmitt@analog.com
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, mazziesaccount@gmail.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, till@linux.com
References: <aapjuiq0JSVWfmWA@fedora>
Content-Language: en-US
From: Till Kamppeter <till.kamppeter@gmail.com>
In-Reply-To: <aapjuiq0JSVWfmWA@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

unfortunately, the IIO group is not mentoring in this year's GSoC. If you want 
to do GSoC this year, I recommend you to apply for the Device Tree Bindings projects

If you want to contribute to IIO Driver outside GSoC, please join their mailing 
list as indicated on the project idea page and introduce yourself there.

    Till

On 3/6/26 06:18, ShiHao wrote:
> hello,
> 
> I hope everyone is doing well and fine. Recently i have been
> getting prepared for gsoc 2026 for The Linux Foundation project
> idea iio AD39113 driver development however i just noticed that the
> project idea has been withdrawn from the list. I wanted to ask that
> whether the driver develpment is still planned or it is dropped from
> project idea list.
> 
> If the driver is still needed , I would be interested in contribtuting
> to its development outside gsoc as well since i have no idea whether i
> would be allowed for its development or not thats is why  any help would
> be appreciated thank you for your time .

