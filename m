Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2025331E851
	for <linux-iio@vger.kernel.org>; Thu, 16 Jul 2026 07:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784187920; cv=none; b=rfTl9XbxgsW5toqNTcqRCIbiJ3UtV2G/6jzB5k4wndNASXUdAXuNjxPbYLnDwONtQrLZoy7RrPBZdTZw9ihl3DmumdhnA8PY+Hvv/IoPaHVT93GXxVDmzo5FuEjMV6XunI0fzCHqQxywfE3YHcdx4Dfl8fsxa0KLYf1Vi+sp4x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784187920; c=relaxed/simple;
	bh=Sg58Yc7uD6ai3S7WWbNmhT4gg8JlC9ALJ9h0k0OJBNw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hO7IGb4GWpfEpRAn5dfFnA3ch2r7UEsgrYYyprXNqoR2Q90FwFJpDXCZ1AW0EmDNf6TdqQofvf3V0vaeeP2ZAjjJ5GUGGGEvUf7FhaXYvciYlxzMQQPcv6nC7wVLhuKUhmJJxXtORJBavx/krzvqxkJ2MmnsBOQLTGZJCrBhIfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CDFmrstr; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CDFmrstr"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-475881b9a4bso2703073f8f.3
        for <linux-iio@vger.kernel.org>; Thu, 16 Jul 2026 00:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784187917; x=1784792717; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fLR7VfJUE9Ja4z8wtpGAktnLppqJBBUvRPlg8yvEoag=;
        b=CDFmrstrgR4RtcQojbPtGQZXpUv9K2XI0xQjVEpwboqsHIk4FjhLytjkvziUwJTPSS
         1Dr0ey02qnzHR4ynMW+pCoY7BrRPuYmv5LgvS2z8OYt5awXXMskKwyV0oDeudvV2N+Q2
         UG4fiIx16wOCQyaGiSN8OJ+zMDrUE6uDskmBgxFOu97MuJIg8FIOsI9DUXQe2QBsixHh
         0y448t9wpzsDTOcL8IHkz2RJhsdWMkeqg0Dw9G6bG6mgnx+oyUUJdaM36DPKYHakXWMN
         bf7uORU6OZYdZJi0ixdTOymkfEq1HWq0LBSaZhnEaHl7z3uZjtqE1TLke7nFzH9REhGh
         x7SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784187917; x=1784792717;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fLR7VfJUE9Ja4z8wtpGAktnLppqJBBUvRPlg8yvEoag=;
        b=ixAww5BTv6t6m3yAH1pybYKnPPNCeoCVz9hOz6fmX1MuLI37uKG2dKDskWFlGBnfKL
         ToTxPZpdmsQ+3Swz16c9ieqLdqwBW4cAYjqJ0zpxSCcJBDLJ5yIspmjPb0CQ/iiBkQ92
         r8epBHzORU4crc0w9giWn5bfVCArjsU73uEzJ6na99a6eyiLDPcK0GHJhfbGmuAo2UGr
         PZH3lxFRXmojaXNC/fROoyMX4KzJj50j49C5yO0FIlEfwa76hfZ2sFgf3ck7JQCh9+oe
         b8HBaefYz1BGcn7VqOSkFCIFhsrQxXAKOts13OVPgABYLNwhKwoOdeyqqz6lso4Ec1BR
         zsRg==
X-Gm-Message-State: AOJu0YyFO0Yo5q9igxSjrVLqxBfRDawVkYQRH5sNM+M/ywOzNDjHsdRJ
	6Crvts9Q1n7XaarJNJl1WBmF7QpWkbitONVFPiLbvluVVF+Qt3F2i68Y
X-Gm-Gg: AfdE7cnOZydGpD1h1sorIamZoucD8IuuB/uJq8QFXU3cEXL4q9UnLxSoZeRW8p4Ns6i
	AEvq4gd1Kn6AWkj/iAJfTyb+hm+yKzi8ibFRYRg9ypKr4Tbv+/XC1Uod+wYVbYILi1gqwJQxZwc
	0DX/z4eTUfsFes9mgxofx/rj80Ev+j4JL2cEHLgwF/H+YrHJVc0pJPgIwAXMcG4LejKoh65Y3fa
	mtX3SZABQxrJ6RTNzviRe2y/7gNzp5EMGfMoKB30qfSQP5Toz8DlUbwv2Vat+nOtVLxsnfe7ZiJ
	UN7eO7hWUuW2Vw4hsHupxfJEMXHJKQRfBEYw18/zM+Dqxsk6muwxn/4oZE+4zR3mIYJHFMdrOZC
	LcNVYEraPvXb7tLu1iwqVdgjlkMXfWxRyoaToW3Gyp+WHh5RudWtw0fmH0QwzSlNIE6ERJOSupv
	TEGExMZPuu6LslwIMLDSTsPzkrh0OmnTOn0vI1YpHcheMPCU2YwaUrA+x14tLMj4r+m9mkhEjSB
	lc8AO0BKFl1DuxWGgFIzvjcwMiAaPuZb1w2WcbPiVa5jsDSg5F9tdexbKOe1fOiQK6FwLphnzVT
	F2VnQvmDEy7fTkgDf7z8pSN5XzTXo9SCXivW6x5sX8/fZs9vmCHTxqYxWK85sWh+/tYUM8ONgLJ
	wY58pH5TIbQnA
X-Received: by 2002:a05:6000:2612:b0:46e:1815:6a83 with SMTP id ffacd0b85a97d-47f2dd1f23fmr27865366f8f.29.1784187917235;
        Thu, 16 Jul 2026 00:45:17 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f464c1f84sm22778028f8f.29.2026.07.16.00.45.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 00:45:17 -0700 (PDT)
Date: Thu, 16 Jul 2026 09:45:14 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>, Nuno
 =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>
Subject: Re: [PATCH 12/22] iio: dac: max517: Remove redundant
 i2c_master_send() length check
Message-ID: <20260716094514.00001eaa@gmail.com>
In-Reply-To: <20260716005737.254577-13-jonathan.cameron@oss.qualcomm.com>
References: <20260716005737.254577-1-jonathan.cameron@oss.qualcomm.com>
	<20260716005737.254577-13-jonathan.cameron@oss.qualcomm.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 15 Jul 2026 17:57:27 -0700
Jonathan Cameron <jonathan.cameron@oss.qualcomm.com> wrote:

> i2c_master_send() returns either a negative errno or exactly the count
> passed in, so the length check after the 'ret < 0' test can never be
> true. Drop the dead branch.
> 
> Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> Assisted-by: Claude:claude-opus-4-8
> ---
>  drivers/iio/dac/max517.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/dac/max517.c b/drivers/iio/dac/max517.c
> index d2ddc72e0e50..e0d1a26c4f73 100644
> --- a/drivers/iio/dac/max517.c
> +++ b/drivers/iio/dac/max517.c
> @@ -55,10 +55,8 @@ static int max517_set_value(struct iio_dev *indio_dev,
>  	res = i2c_master_send(client, outbuf, 2);

Someone should also remove all the hard-coded sizes, they appear in multiple
drivers you're touching.

-- 
Kind regards

CJD
