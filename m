Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56CE83A1E67
	for <linux-iio@vger.kernel.org>; Wed,  8 Apr 2026 08:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775636997; cv=none; b=hfoONRMoSLC+T99vbag0ZlXRG8qNZUpo/w8t6lr9iTWdXyDUKsFcF/ASUZcNlAQEjrNP8tgDnZ7SF3GxwGIAv1zX0bkoGSU/L2UBSrscer1LX9q6QGs6O66+Xf2Vl5UYBu4UPwY319hEerQL40NWUpCq/EC71HfUleaZIQ2HY8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775636997; c=relaxed/simple;
	bh=/N9nDgGBUx2xNQj/8J/V+x1gepv5/QyqrTKMRR9IgJU=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=MiQpZzrOy+2iIJaJrTDhMJ8d8Z9Xelub8MpsiZbeKdIi3nw5HxiA7CmyKFfX1RL7VaSgYQeY+eyXc1kzmC35RLyFsK/ioTKPXPqGe9Z+YVpMtF+GUPZ2sDGlHdAdUIr2g5nXWhx8O7ePOFsUDTbhVYYq+YT3v171C7zttFn7VaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F1HDNG3Y; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F1HDNG3Y"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2aaf43014d0so41507545ad.2
        for <linux-iio@vger.kernel.org>; Wed, 08 Apr 2026 01:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775636996; x=1776241796; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=D3GLS/fnV1kV6HHNA7BZp2uu/52HjF+3WXvNfbBxqW4=;
        b=F1HDNG3YLIkSjVat6tNy5BaEAgBk8aymxNBIj2jT7UWQ5lZZW1xKS7HfFk9UOLkezc
         kKixG0V5UQVDSpsdDT4C3k82jirEoPNI2ayvQiKOjG3Quk3OVw+2HcwyPDBQvxcMcAMe
         6a0uHLQA03B/4z1VMST3JlqsL8TB7cFVMImJmV/Y4yEsZaxaPkvtsmMEFwFv6axexMpe
         JlQTVAoRgX3sZuV9STX0GgHJ4SURJaHb5rBQb1yhRe3ALXl5D6X8c+Q/Zgbo/J29+dnX
         KDinfXaaIt1exHe9DK0woO8XkUgbkhKaR1rqqjtnG54+qEMKOKhRvZxFckfsV9XizgvB
         mGoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775636996; x=1776241796;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D3GLS/fnV1kV6HHNA7BZp2uu/52HjF+3WXvNfbBxqW4=;
        b=EDkQAGfAKtcOjaFocb3I0/6BKiTkqhRm4jtRZrD+hmiKovt+lAhUAXjnEnJFMRwE/n
         rHwNgWStbItzZWnoT2FiSlXe7/+ccXmWOXXrGNYvB9TBPc00k2sSQIAQoaHPn1VdEuix
         xjr+Syfnlc9N65sQSPgE8CqVmmGTQ47/NJLjDnLESoCFKFe/pMZsp8a1rJLy2P5PqDnr
         NUcVO/3K20qN3x3/oTnkVwLgGcV6MJmg8rZyqgWtOazL54IYg8zju3CoWkCieeZzfsTg
         r5u6JtjWqa21Prd24CVciw2PZjpI9k2EbGPFzfbTF/mvO1OjaI2/E+a4BVRLMnNoKAHN
         HHwg==
X-Forwarded-Encrypted: i=1; AJvYcCVIpxpuD00TN0c+tu2e69/E2EV6ZxSAU74zXDfAuaIxS+n7MwUYda9fJW286pFfepMpGZxl5XzUO5I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDksOP2MqUCujkKiykbs4U158ZOg8cozZ1l1afAyVKcZrQlsUq
	XC1qeOtfrk0GZmBIrfoNNsZ6cHgW5vt4fYbrbsjuikqdNnrRouJCNhys
X-Gm-Gg: AeBDiesjQylXlX3kBxSnNjbIccPH18QCta77azW+Bt2D7a06WT2u81WmpS+f6kwaZW9
	kpWwCkH9w5aW4A3XTrSM1cQTRKG3yAtCbdkRS97pCvOZ2U6HoE6OfcB1gTQzfRH7XVtxsZBBEW3
	OmghyJWJjpJT1hDYRApIcK6kvzAI6qeNJ+j9vVMxEBNVw1Bp8Aj2QvCkqRhnmg+E1wPwGKPeRJM
	rt2Ifgv3NpxDgzn3fKujF5biPj4aSaD+XwKblXGieP0VPIPlXLbimhZyNrNZpXAl2KeduKkN+5z
	q/FMyMi4D0Boh6mEvngRchuEECk47RW8EDhKz6pYBHiCfyQDawrxm3x+emnJjmCocupWxXzwXFH
	RUlPV3LGKol7qD3Ll0BhV+ElDHZdIZtteAYokhKVOQq4n+aam0udPkRc0ylxqL+wCiPSacr1opj
	oV8ZqdWQ6DaixwTkQm0WcuYMItV/AUjn1xNVJBXsjx3iSpvo4=
X-Received: by 2002:a17:903:3205:b0:2b2:4eec:9806 with SMTP id d9443c01a7336-2b28182ca4cmr238395465ad.8.1775636995535;
        Wed, 08 Apr 2026 01:29:55 -0700 (PDT)
Received: from ehlo.thunderbird.net ([2401:4900:ac07:a748:addf:cbb4:8118:a551])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b27472d1a2sm209392515ad.7.2026.04.08.01.29.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Apr 2026 01:29:55 -0700 (PDT)
Date: Wed, 08 Apr 2026 13:52:08 +0530
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
CC: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 kees@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v5_3/5=5D_iio=3A_ssp=5Fsensors=3A_fa?=
 =?US-ASCII?Q?ctor_out_pending_list_add/remove_helpers?=
User-Agent: Thunderbird for Android
In-Reply-To: <adQR2ZKVOavHlJDt@ashevche-desk.local>
References: <20260406080852.2727453-1-sanjayembedded@gmail.com> <20260406080852.2727453-4-sanjayembedded@gmail.com> <adQR2ZKVOavHlJDt@ashevche-desk.local>
Message-ID: <6878A01C-C546-4719-86F5-F1571B4A198C@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 7 April 2026 1:34:41=E2=80=AFam IST, Andy Shevchenko <andriy=2Eshevchen=
ko@intel=2Ecom> wrote:
>On Mon, Apr 06, 2026 at 01:38:50PM +0530, Sanjay Chitroda wrote:
>
>> The SSP SPI transfer path manipulates the pending message list in
>> multiple places, each time open-coding the same locking and list
>> operations=2E
>>=20
>> Re-factor the pending list add and delete logic into small helper
>> functions to avoid duplication and simplify transfer flow to follow=2E
>>=20
>> No functional change intended=2E
>
>Suggested-by?
>

Requesting your input on which email is recommended to tag with your name=
=2E

Shall I use intel=2Ecom ?

>=2E=2E=2E
>
>> +static inline void ssp_pending_add(struct ssp_data *data,
>> +				   struct ssp_msg *msg)
>
>Make it rather:
>
>static inline void ssp_pending_add(struct ssp_data *data, struct ssp_msg =
*msg)
>{
>	if (msg->length)
>		return;
>	=2E=2E=2E
>}

It should be not, right ?

{
if (!msg->length)
        return;
=2E=2E=2E
}

 const bool use_no_irq =3D msg->length =3D=3D 0;
 if (!use_no_irq) {add/del}

If message length is 0 then no interrupt

>
>> +{
>> +	mutex_lock(&data->pending_lock);
>> +	list_add_tail(&msg->list, &data->pending_list);
>> +	mutex_unlock(&data->pending_lock);
>> +}
>> +
>> +static inline void ssp_pending_del(struct ssp_data *data,
>> +				   struct ssp_msg *msg)
>> +{
>> +	mutex_lock(&data->pending_lock);
>> +	list_del(&msg->list);
>> +	mutex_unlock(&data->pending_lock);
>> +}
>
>(in the same manner)
>
>=2E=2E=2E
>
>> -	if (!use_no_irq) {
>> -		mutex_lock(&data->pending_lock);
>> -		list_add_tail(&msg->list, &data->pending_list);
>> -		mutex_unlock(&data->pending_lock);
>> -	}
>> +	if (!use_no_irq)
>> +		ssp_pending_add(data, msg);
>
>=2E=2E=2Eand then it will become
>
>	ssp_pending_add(data, msg);
>
>>  	status =3D ssp_check_lines(data, true);
>>  	if (status < 0) {
>> -		if (!use_no_irq) {
>> -			mutex_lock(&data->pending_lock);
>> -			list_del(&msg->list);
>> -			mutex_unlock(&data->pending_lock);
>> -		}
>> +		if (!use_no_irq)
>> +			ssp_pending_del(data, msg);
>>  		goto _error_locked;
>>  	}
>
>=2E=2E=2E
>
>>  		if (wait_for_completion_timeout(done,
>>  						msecs_to_jiffies(timeout)) =3D=3D
>>  		    0) {
>> -			mutex_lock(&data->pending_lock);
>> -			list_del(&msg->list);
>> -			mutex_unlock(&data->pending_lock);
>> +			ssp_pending_del(data, msg);
>> =20
>>  			data->timeout_cnt++;
>>  			return -ETIMEDOUT;
>
>Also rewrite this to follow the style (missing {}, better indentation):
>
>	if (msg->length && done &&
>	    !wait_for_completion_timeout(done, msecs_to_jiffies(timeout))) {
>		ssp_pending_del(data, msg);
>
>		data->timeout_cnt++;
>		return -ETIMEDOUT;
>	}
>
>And kill that use_no_urq altogether=2E Move the comment rather to a helpe=
r(s)=2E

Understood, will follow and drop this variable in next series=2E

>
