Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50CEC379979
	for <linux-iio@vger.kernel.org>; Tue, 23 Jun 2026 23:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782256146; cv=none; b=ebEzOffHG9p/ttT0u+kUy6t6zxgilSZt/taB+BPldzz+NneAzDYxKKFAakqFNVBn0HURuAcZu5Rc2774/aWF5pLSEgRhtRcIzLQ5Q1uw4YPYeuC2qC7NKvLAfZkk/ilOn3c4Ctfoj344/+fMkAviqJ4AhenJrTdG4gEmKisY6ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782256146; c=relaxed/simple;
	bh=W6rsFmfTw3RYbSPkCGbJlZykQdK8UUiSToog+FQLz3M=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Hx2mRFPQrI2RfZOraC2WP/r4wOjKPeLNO0U0UW05v5kU+7bIitsk8PwKmD9XdkwqdXV6NijURyl6/gqb9hWxWL/j/+d3YlhiRCCU3Xd2KbziiKTNblbgpZ4G69tyT0wMkVWhT0o44HjxvfGuNHCmDe3w9OWKOa6gOE+Dsd7T7Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=ZHkfs9iu; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="ZHkfs9iu"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7e93c3f1717so214220a34.2
        for <linux-iio@vger.kernel.org>; Tue, 23 Jun 2026 16:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1782256144; x=1782860944; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wtdeomxEC7+mkEA/dEebMKVj9k0wNEeEB423Anz1+qw=;
        b=ZHkfs9iusZ9RNuip+syX+ABDjkw+ONMOWIk6sEvbf38srwZgx1PFVGbqxJYY3AqEuQ
         AyfaSMSJFlZqyJp4Yk0Q7mbacW0FootTbpg+zsklToY2hDlrds5irhqsXBW0ZwHzDcdT
         x/QhR/EJ2lK/hyAtx9JTG/5HFPX/4KBKK/RTIMBzF4HHReYtHhzamKUh9/4wYOCDP76w
         mZ+pZj/kq6NmKdOUvyYDGf3VMCL8TE8dXITBKz0+RlmXZgQkKLiOhIJMChyxV1oOgq66
         DUvSDhNAl+hn5t7qWzQb4I1YPKQGVOwy7ahwt3wKr2zJ9ofo7l0ELJt5D6d6un4Xxiou
         NUrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782256144; x=1782860944;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wtdeomxEC7+mkEA/dEebMKVj9k0wNEeEB423Anz1+qw=;
        b=sA1mhER8gEIoNbHCZYTI1Ljz0AlFIsgjyPFpcKLF/JIZvDKri1PygDAia002phez5S
         ZTHkb+jSpBfnK2DtWkyrLnHUkwqFsrBFq/TEKaKDXvneG0XH6TAUrAzsox2WFSbYb/yO
         Y39q17jWGhb44DreE+wHPEnJF2FcixB66ldOp8oqewFv9NFOGc+cd+tf4fm8SbA/eYV1
         tJem+n2to4pmMnD5cUe9bpl9QOEHIFj006W497dAbgi1S6M3yQZU5yR6VTjYb+cRK54m
         ev596VFzkzChQQkpbzNZ12zzX4+eF6N0s0ESzn8Um+3VWs7Dsj49ENjNgJLnusyjPavi
         /neg==
X-Forwarded-Encrypted: i=1; AFNElJ8e0KYKG0WBOV0Bq/Y/2Azv9oecsjwCsa9pVef/ZzrIsT84EVFAkEFwkpOOtGtR5v28z/rdrmXe6OM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCpZynxmnVK7reZ4IWlHg4iAyLDCV2BGQigKmGeNxOwfHHb9R6
	ul5nUzR5SXXTX93OTRAGXO5XPMCSjmshdhETa7QSCSwC5fJnkc6pbH1RA6HtgDpaTTA=
X-Gm-Gg: AfdE7clal8pWPAa3AgXT6WMJS+06WWucoWfON1KLJAPeI3jWqMQAPq8w0mmvbFvkOX/
	WNTW1Xy5aNp9GG7Rl28sEuvuryCliF0Zmt+eR9eg5lYafH9xfCvIO2mG2JSkp5ntYZKzxj5IYMl
	inD7gQZg+PMm062uTZq0uI8e8ucd4bnjd1CuCjCfIAlVhlswixcWUzCddH2/fWbXMT1NYzRL2BS
	gUX2wJexgM1pLiysJUN8MM6+DZa7+vh7Os88L0EX/HbSmrLZC2JNjoG7/RNeJEFWZqUVDwX3sVN
	0/gWZ04bGq5shRsK5wZhqWuR9AUSIIC5WytHLFZYx08q0dUZG1GMlTv1HjN7A7bEUuKg0GG7lk9
	e4rSB+2gK49CoeCrsGfoRFoOTgBCB/B6i60+PuaqXAlCOPyLs2UjEI2Db6FdS99TUVZxJmUkLYn
	toIMpwlM+P01I8/bwLUINDEg9oCa54q1NZaKc701kUk7BqRjcAxZYFoPpJQTDOOcQ=
X-Received: by 2002:a05:6830:6a12:b0:7dc:dd19:7f53 with SMTP id 46e09a7af769-7e97947c858mr3717034a34.14.1782256144259;
        Tue, 23 Jun 2026 16:09:04 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:68dc:b788:b3ac:e34e? ([2600:8803:e7e4:500:68dc:b788:b3ac:e34e])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e944068bb7sm9764689a34.9.2026.06.23.16.09.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2026 16:09:03 -0700 (PDT)
Message-ID: <1a217276-17d3-4d3c-826d-24255b6d4018@baylibre.com>
Date: Tue, 23 Jun 2026 18:09:03 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] iio: adc: ad4080: add backend data size configuration
To: Antoniu Miclaus <antoniu.miclaus@analog.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, linux@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260623090717.3296-1-antoniu.miclaus@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260623090717.3296-1-antoniu.miclaus@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/23/26 4:07 AM, Antoniu Miclaus wrote:
> The AD408X AXI core can pack sample data on the bus using different word
> widths (20-bit, 16-bit and 14-bit), selected through the packet format
> field of the CNTRL_3 register. Until now this was left at its default,
> which only matched the AD4080 20-bit resolution.
> 
> This series exposes the packet format through a new data_size_set backend
> operation and has the ad4080 driver program it during channel setup based
> on the channel resolution, so the bus packing always matches the device
> realbits.
> 
> Patch 1 adds the data_size_set operation to the adi-axi-adc backend.
> Patch 2 calls iio_backend_data_size_set() from the ad4080 channel setup.
> 
> Link: https://analogdevicesinc.github.io/hdl/library/axi_ad408x/index.html
> 
> Antoniu Miclaus (2):
>   iio: adc: adi-axi-adc: add data size support for AD408X backend
>   iio: adc: ad4080: configure backend data size
> 
>  drivers/iio/adc/ad4080.c      |  5 +++++
>  drivers/iio/adc/adi-axi-adc.c | 30 ++++++++++++++++++++++++++++++
>  2 files changed, 35 insertions(+)
> 

Reviewed-by: David Lechner <dlechner@baylibre.com>

