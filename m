Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D81363C48
	for <linux-iio@vger.kernel.org>; Sat, 28 Mar 2026 06:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774680859; cv=none; b=d9ZfI1Lfucef42xhUurG9HN/Vqf5/jgst/bQ1P5EBwppbmqUdQ1Lu9OBjs2PUz1jwi7cwKybDu8ezdUpoPEvwGw+DckI/UMoGfLAVhaUMucQUxeLXab44TTr/4hif//GWklVymknWXwubhI6yK1+ODFUHyk4q7DyviDOgL4xrcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774680859; c=relaxed/simple;
	bh=zdbqDmrWAXPv+M+4a/tZXabUg0TKEf0tWCgZzKGrQP8=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=qNu+N8rrMZ3ZfGF6dO0SVrD3HCZ0kSqH1fgHb2K5NDfmce+d87Tk/T03YJdHhfVAB10K8ytdOW1oqWFJHo0uWuZvmrxhrCw/bV0/nRNRvgl752MA2pW0pjyt3V+6cnmD4uAl+GcqnWSAsxunCvwp2n1j/5KSpvc0FgW/G2VC6tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cIzWkOXi; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cIzWkOXi"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c06cb8004e8so1133480a12.0
        for <linux-iio@vger.kernel.org>; Fri, 27 Mar 2026 23:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774680857; x=1775285657; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kXKhy/6eAEx+urE0a4vI3mcdRxcRjnEsn4KfGLMmxnQ=;
        b=cIzWkOXi2b7GPCq/jJR1UJ463GNzzGLIEREBhZ6zFa/X3nuq9KEaDP08e1hlkzlCKc
         PIv9r/XcGAt/Hma/m1m+p1FVncWrYFXNdIZe1bswwMhYzcVa4GC7jSDGfkkpkbfLS480
         kl9LZ8zdmCG4zQqHG6FgMawAeQ/baHfnUMUgq/ZK4UxGij0Klc7uABuJFm6mC5upXCPo
         vJgTEUWJhavYX1DtdF0XxOA+6Km4L+dE4WwgAylmjQGTwF2skdWZt+YCaG6rklX9I7N+
         OYdE6Wzu9GGjHo8Z/mWJPHkonOk8J1uhbMG6HJ+b/kkEKNaIZJ4sz8NsgGsE1CcVUYxS
         tulQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774680857; x=1775285657;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kXKhy/6eAEx+urE0a4vI3mcdRxcRjnEsn4KfGLMmxnQ=;
        b=SEap9c6E1cYR5jWSHAux/zTXJYdEP+6Ijg6JmSY6n5k6QGaAFWF5uAJquq6L7fNIie
         HmVCRQ8fc6WSOeD7EHesNJYERY68C8ICzgIs9G3H5PXmMz2oJJpcRWFjifxaFl8twGNX
         q+hSP7L1jeUJXndHZM0MTldKcE1CjEiR75vMJzB4xhLsCT5aX1pewWdgBot101bv5ltx
         WIlPFO9+hsBJGZNTHvkUsnLsGYgliSukoTMBboVYl9DBItLIzZV2krKbt2GC83G41cN7
         VDoYRfpLMvNB7sbsKzBC+En7BPYfHv0TZtz2LrUiA9Em+kL+0S5F2oyAvuKWmmnlwbCz
         8fsw==
X-Forwarded-Encrypted: i=1; AJvYcCUKsGfWVgDSt7Cr5A9dMJkdxzJDNmOuKppE/XueJHzQ3Pl2npv4OCOPUR7XVUHKon9em+jr9XJ35/U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTh1yFiq9mc351aGoX1y9/SGBnOSlf0IkB6e/TEePP/pvQwohl
	O9uefM6kNo/wrOXlm5klPGbLZ69jgK6qXaDLO8vTM1ieO0EpQ2W92FbE
X-Gm-Gg: ATEYQzwBMyG5xb+CZA2gtRccKgqCoxtPJ0sX0caenZdUOK+OO0di0LtNPOt+tHFk2Mj
	r2+Vum6nQznwZcahwdrN7Te8l0QsquDjbAnPrf21FDk/civ0uvJi558fk5tntHky0I8ipovveJ2
	Gu1fhUcr9AidRebTb9nLbcL4pumy34tiI14r6NoCug9YI14Zc4Q4YvxMN4GnNfXPxN++I6y33wt
	8uujeTOVsyxmSpr7R/e0jj7XIqwNZYOVh/iOngge/3b6F5pU3J5K6UkHIHG7McYrBJ93CDNgCtn
	Ix00vElwCfZ/kIC1bKn0v6oD9grJzj0wFGDquSP8wyu550cRX73I888S+POh79C12RMyqZ+amS1
	DcGUGSJYMphrLQcz8JC4u7loLbteUOrBdf118c482+b5QbX4EmZ288AKn3hLyQB5S5AK4U9cXM+
	CWbAmTk9GOiKCP5x8dl8MeCWQf+e/yVeED71OYN0A65l7RG2I=
X-Received: by 2002:a05:6a20:12cb:b0:39c:39de:3cdd with SMTP id adf61e73a8af0-39c87833c86mr5674899637.25.1774680857446;
        Fri, 27 Mar 2026 23:54:17 -0700 (PDT)
Received: from ehlo.thunderbird.net ([2401:4900:c025:8972:d954:bef4:d140:e202])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76917bacc2sm960152a12.26.2026.03.27.23.54.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Mar 2026 23:54:17 -0700 (PDT)
Date: Sat, 28 Mar 2026 12:24:11 +0530
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
CC: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 kees@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v4_3/4=5D_iio=3A_ssp=5Fsensors=3A_s?=
 =?US-ASCII?Q?sp=5Fspi=3A_use_guard=28=29_to_release_mutexes?=
User-Agent: Thunderbird for Android
In-Reply-To: <acT6vokgYuUTsWcj@ashevche-desk.local>
References: <20260326081815.925373-1-sanjayembedded@gmail.com> <20260326081815.925373-4-sanjayembedded@gmail.com> <acT6vokgYuUTsWcj@ashevche-desk.local>
Message-ID: <4017E54C-B25B-41AC-B4E1-F28576C2D64C@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 26 March 2026 2:52:06=E2=80=AFpm IST, Andy Shevchenko <andriy=2Eshevche=
nko@intel=2Ecom> wrote:
>On Thu, Mar 26, 2026 at 01:48:14PM +0530, Sanjay Chitroda wrote:
>
>> Replace explicit mutex_lock() and mutex_unlock() with the guard() macro
>> for cleaner and safer mutex handling=2E
>
>NAK=2E Please, be very careful when do such changes=2E
>
>=2E=2E=2E
>
>>  	msg->done =3D done;
>> =20
>> -	mutex_lock(&data->comm_lock);
>> +	guard(mutex)(&data->comm_lock);
>> =20
>>  	status =3D ssp_check_lines(data, false);
>> -	if (status < 0)
>> -		goto _error_locked;
>> +	if (status < 0) {
>> +		data->timeout_cnt++;
>> +		return status;
>> +	}
>> =20
>>  	status =3D spi_write(data->spi, msg->buffer, SSP_HEADER_SIZE);
>>  	if (status < 0) {
>>  		gpiod_set_value_cansleep(data->ap_mcu_gpiod, 1);
>>  		dev_err(SSP_DEV, "%s spi_write fail\n", __func__);
>> -		goto _error_locked;
>> +		data->timeout_cnt++;
>> +		return status;
>>  	}
>> =20
>>  	if (!use_no_irq) {
>> -		mutex_lock(&data->pending_lock);
>> +		guard(mutex)(&data->pending_lock);
>>  		list_add_tail(&msg->list, &data->pending_list);
>> -		mutex_unlock(&data->pending_lock);
>>  	}
>> =20
>>  	status =3D ssp_check_lines(data, true);
>>  	if (status < 0) {
>>  		if (!use_no_irq) {
>> -			mutex_lock(&data->pending_lock);
>> +			guard(mutex)(&data->pending_lock);
>>  			list_del(&msg->list);
>> -			mutex_unlock(&data->pending_lock);
>>  		}
>> -		goto _error_locked;
>> +		data->timeout_cnt++;
>> +		return status;
>>  	}
>
>> -	mutex_unlock(&data->comm_lock);
>> -
>
>Pzzz! See what you are doing here=2E=2E=2E
>
>>  	if (!use_no_irq && done)
>>  		if (wait_for_completion_timeout(done,
>>  						msecs_to_jiffies(timeout)) =3D=3D
>>  		    0) {
>> -			mutex_lock(&data->pending_lock);
>> +			guard(mutex)(&data->pending_lock);
>>  			list_del(&msg->list);
>> -			mutex_unlock(&data->pending_lock);
>> =20
>>  			data->timeout_cnt++;
>>  			return -ETIMEDOUT;
>>  		}
>> =20
>>  	return 0;
>> -
>> -_error_locked:
>> -	mutex_unlock(&data->comm_lock);
>> -	data->timeout_cnt++;
>> -	return status;
>>  }
>

Thank Andy for pointing this out =E2=80=94 you=E2=80=99re right, using "gu=
ard(mutex)" here unintentionally extends the lifetime of "comm_lock" and ca=
n hold it across the completion wait, which is not safe=2E

I=E2=80=99ve reworked the change to keep the original locking semantics in=
tact:

- "comm_lock" is still explicitly unlocked before "wait_for_completion_tim=
eout()"
- No sleeping paths are executed while holding "comm_lock"
- Introduced small helpers to simplify the flow:
  - "ssp_send_and_enqueue()" for SPI write + pending list add
  - "ssp_dequeue_msg()" for safe removal from the pending list

Updated flow looks like this:

mutex_lock(&data->comm_lock);

status =3D ssp_check_lines(data, false);
if (status < 0)
    goto err;

status =3D ssp_send_and_enqueue(data, msg, use_no_irq);
if (status < 0)
    goto err;

status =3D ssp_check_lines(data, true);
if (status < 0) {
    if (!use_no_irq)
        ssp_dequeue_msg(data, msg);
    goto err;
}

mutex_unlock(&data->comm_lock);

/* wait outside lock */
if (!use_no_irq && done) {
    if (wait_for_completion_timeout(done,
            msecs_to_jiffies(timeout)) =3D=3D 0) {

        ssp_dequeue_msg(data, msg);
        data->timeout_cnt++;
        return -ETIMEDOUT;
    }
}

return 0;

err:
mutex_unlock(&data->comm_lock);
data->timeout_cnt++;
return status;

This keeps the synchronization boundary unchanged while reducing duplicati=
on around pending list handling=2E I=E2=80=99ve also limited "guard()" usag=
e to short, local critical sections only=2E

Please let me know if you=E2=80=99d prefer keeping the list operations inl=
ine instead of helpers=2E
