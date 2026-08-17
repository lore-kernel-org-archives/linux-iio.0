Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320FF3B637E
	for <linux-iio@vger.kernel.org>; Mon, 17 Aug 2026 21:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787002168; cv=none; b=PRnvlqeyiRHFw/pjQ/ijXYCrcU56huR4LH7elLWUvFnBPRyn8fzTnDQgSnkMUG1cqK9LVlbOTTybUO++D3nKE7rtkimlFOUj3m5b/gFB2KHheBri4iVP7TpqeN0USAEK5yFW8Z3H29cqius01/H9wWM/F27VSFPw84UxiiNQAhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787002168; c=relaxed/simple;
	bh=RRjYjO9utSwXFNiNlGy5THKzfGm+sRKB/dDa4OjFrtU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bjw0itJ/uyTmsI26WvJMGLlQXVLbyjjNxoUj0fMsRjnBvdfg3SR+VMWmDGKbOm23py58cxYf5CUMPnA/OR6rjDgt2f8laelqjccF7WW7APd82D3FQco7jszK2WDTo5Y1GYx9xfz0WBP2x87mdzXZNqNnXa0oRXybaHZ0Q0pn678=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hoqc8OOb; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hoqc8OOb"
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-9696319e14dso1201975241.3
        for <linux-iio@vger.kernel.org>; Mon, 17 Aug 2026 14:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787002165; x=1787606965; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XiXCkGd4+m7MSxEiROxY/FH+NnJuFc43Sy6i9qtL4cg=;
        b=hoqc8OObrTRSktIYGRswLh0Swr69w45sBeEdhTkukpOlKpgtQ4fdxDJ8hUrmqSETN8
         IncKlBoEIHuLFU4DSq3OslZd7rfGnS1/3hCPFQ01PQN1JS/0vCo2NstXnilIBd5gmnPh
         82mBywHYBAXdzouZ7+SgsD4Ul0jrxJa8cGXqSSBrGjeE+oNORWwEuH3Mr89LSAFtU7wC
         RbK7UABLQpl4PM7WLObkfUKI0ohB54vyi1E+cGVv4tYPXGvFVYrYpNobw8wHq6sgdPqI
         LWr9B9PlowBWo3WMkclbd/MzcRBDNbV6ILlelT29CZzLoeBvJoy5emknEP/GA8L+Ovb/
         fxxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787002165; x=1787606965;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XiXCkGd4+m7MSxEiROxY/FH+NnJuFc43Sy6i9qtL4cg=;
        b=chTJzyf0UGT6ykyL8mUtUky+OIJtnQvoRD+cyL1eWMd5uOLk9+HWPJB8MCba/Rsdb4
         b0S+Tdz5shDfocsxIhNdKxnHf/pmYbv65E5EUCe6VZMbG2RYf7mZPLMYgg59TFMjbL3v
         yvGh6GIh8dUVtsuskNsu4ACXOyojz/ntLXWwIOngI/C3HBYfKnH3tNElCwvv9vCIJv0U
         pM/T/RZUFaiADap8R9ghfy9c3WMioOR/EPD53cRVCpighYHO0/VlTg1GYv0rDLYglAdu
         IILHx/HuSPNcbjOl+GO31usX1ejXqTmnzvSAvp7iB6SHKJnIBc3gfjBKst9Garl8ZMX/
         KdtQ==
X-Forwarded-Encrypted: i=1; AHgh+RoFLL11/Qhfb5HojbnpgWfvvx5uBj3SLJ2Z6w+M4oVxAyM87vRYiDHcE2smkDjUuGPqrY21bjxWw9E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn+piM9/AcNYMzeUDKMhTe2w4p4PP+fQ/QvXGo6HDATlI9nQP4
	7Idjt6N/cwxuKVJSxD2snaoHLe+mPOM/Ssde0Vtx1Uhd2Hrk33vXIW/N
X-Gm-Gg: AR+sD13IYM6OVVD7NRpRiSKFYxf9f/c0mBhsSvnL/W4l5lxTF8GwWqdIKHyDHQr5WCi
	grCugZCFl6/3JqqjwBbA47RJ1QztF0/rIcKH6QB8uW5qr41XfV9MHK0kUNkmjPwj5S3zZB159A/
	uFFhjSqF6LJBuouYKJCjqAEsrhcVa1/Cv2j5zH0rFY6KqyBT4Il0PszaWwucwA1mbEI6/qZVNtN
	HizGqzBxBaqzKvyoHO4oZifMfks8s/1uzwothhnbyRabaxgTnG9E5bZX8KiQW2k1x4YuCDO8f2k
	rTi7Ezy4KuWffQIHhON2UTczgqL7SOR0LDL9b21dOv8L8kFXEBCqDDktxWuih4GEzo4JvdMZHjy
	jBvKftBU1GgRp+COQijKdNf1/miavyQZVAgbe4saVBjmij2H6B0ATgkWYqhjHYLUbWd3N7Fvstv
	AdTaLU17kYvROlUQeJel/8xCz5e7KOlZ/0THVx93JF2ZgF/TnUOJZgfEcizw8wnG2OKQVsGNwrt
	yvYsQ/aumTQ7yqXzFRwXfzeyIatGLLxQbFX2qcYWeSIDPb1rdelKwzJmZcXkgR5pGZwJoCQ
X-Received: by 2002:a05:6102:6898:b0:738:1fcb:f276 with SMTP id ada2fe7eead31-7747c0b68c9mr783524137.1.1787002165013;
        Mon, 17 Aug 2026 14:29:25 -0700 (PDT)
Received: from ?IPV6:2804:14d:4c64:82a2:de83:b808:5922:82d? ([2804:14d:4c64:82a2:de83:b808:5922:82d])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c5c78eef7asm1683621e0c.16.2026.08.17.14.29.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2026 14:29:24 -0700 (PDT)
Message-ID: <9f0a6334-f40c-4e19-928f-57b709bbcea9@gmail.com>
Date: Mon, 17 Aug 2026 18:29:17 -0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] dt-bindings: iio: proximity: move LIDAR-Lite v2
 out of trivial-devices
To: Matt Ranostay <matt@ranostay.sg>, Jonathan Cameron <jic23@kernel.org>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 mranostay@gmail.com, ~lkcamp/patches@lists.sr.ht,
 linux-kernel-mentees@lists.linux.dev, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260810192131.153495-1-rodrigo.gobbi.7@gmail.com>
 <20260810192131.153495-2-rodrigo.gobbi.7@gmail.com>
 <20260812053450.2e14b074@jic23-huawei>
 <F_gQH7S7C_a2e4gmKfLMZwNzMQ2lvOoBcv-tqJsuNGsWYdJdV-KhzKRPTqo1JS4yGoBK6bn4lscAS3et1Uxm-obr7Tjw3hzePjHOllpSlc4=@ranostay.sg>
Content-Language: en-US
From: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
In-Reply-To: <F_gQH7S7C_a2e4gmKfLMZwNzMQ2lvOoBcv-tqJsuNGsWYdJdV-KhzKRPTqo1JS4yGoBK6bn4lscAS3et1Uxm-obr7Tjw3hzePjHOllpSlc4=@ranostay.sg>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/12/26 07:11, Matt Ranostay wrote:

>> >
>> > diff --git a/Documentation/devicetree/bindings/iio/proximity/pulsedlight,lidar-lite-v2.yaml b/Documentation/devicetree/bindings/iio/proximity/pulsedlight,lidar-lite-v2.yaml
>> > new file mode 100644
>> > index 000000000000..e19c8d166b81
>> > --- /dev/null
>> > +++ b/Documentation/devicetree/bindings/iio/proximity/pulsedlight,lidar-lite-v2.yaml
>> > @@ -0,0 +1,64 @@
>> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> > +%YAML 1.2
>> > +---
>> > +$id: http://devicetree.org/schemas/iio/proximity/pulsedlight,lidar-lite-v2.yaml#
>> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> > +
>> > +title: Pulsedlight LIDAR-Lite v2 range-finding sensor
>> > +
>> > +maintainers:
>> > +  - Matt Ranostay <mranostay@gmail.com>
> 
> I really don't use my gmail address anymore. Would be ideal if it was changed matt@ranostay.sg 
> Other than that don't have any issues.
> 
> Thanks,
> 
> Matt

Thanks Matt, I will send a v6 fixing the e-mail. Since you're fine with it, would you
mind sending a formal Reviewed-by/Acked-by?

> 
> 
>> I'll need an Ack or Reviewed-by from Matt for this. If Matt either doesn't
>> reply for a while, or isn't happy to take on this much fuller binding,
>> is it something you'd consider putting yourself down for?
>> 
>> Otherwise LGTM
>> 
>> Thanks,
>> 
>> Jonathan

I'm happy to be added as a second maintainer for this binding,
(I can add myself at v6) but I'd rather defer to Matt as the
primary one for now.
Thanks!
Rodrigo.
