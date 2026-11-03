Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793707936;
	b=zpoYAcRey3IN0b3LdpXoVJfSc4eYZaCsLlHIrPBQBGlNK7H/18pLI08/X9x7jj6lF6pT
	 xzsEEa+rYfJ9bFKeWs8zOaOysXvpKfK9o3S6qdbCUXcrrHFBWEq91GJ+mJsq9c2QA8SDZ
	 zwYkStgmzssSOMubX+9P+4t2xqCHzYSvKBpteVnnu0nGxKFZb60C92MfcXTFcNo+ucUZC
	 Fm2xwLxrVJeAP1fA0Um4oIMXRPUUj9jFSlZvGAJGATEwTJ41wqXTLLH/5cg7irhZtPOCX
	 j1BJOhozKAe7nSe6AHrsBzwJ+JvCEHPQNqJU+zGsHntf5qDrqZnngI+Jm4LDvDHqFAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793707936;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=/OA40tUqMOdAoYzZGtz7qynGnlFfj2rERGVim4MgYtI=;
	b=Pz3M2Ho/b9AbKvYZeqQH7L5zTcmA0m4iZ+dpHLGyikflaSiJeVWZwrV2RUkAdDreoiUw
	 4DqXIbFoBkXLFCAoqovdqCyvUEzwdC8V8qeJIw2BACuVDWCL0Xef2rKmFDxJrJxTDn4y2
	 vWrXktLhxlSOs/enfDIr1SKHl8IovuKcDzGa5p9QjwCH8KrMe3Setclh5JgAT7rhA526z
	 BKo7xuSw96iNCdfkwvUZ8oaCkbmyLmd3P4N3CT3w//fyG80AQrjO16z9MKRvZdjr6/jCe
	 fKFiVIWrL6TCgnvVaDrqkLSexAUAisHikuDpkvu5RT689/Y7Cu0qd+x0xmIuVIvVv8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BqCNFppw;
	arc=none smtp.remote-ip=209.85.215.171
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66762606A33F
	for <linux-iio@vger.kernel.org>; Tue,  3 Nov 2026 12:12:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 66762606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BqCNFppw
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-cdab6ae1ee9so1689484a12.1
        for <linux-iio@vger.kernel.org>; Tue, 03 Nov 2026 04:12:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793707936; x=1794312736; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/OA40tUqMOdAoYzZGtz7qynGnlFfj2rERGVim4MgYtI=;
        b=BqCNFppwAvgVulzuwP0LIlMReuwYec6PKbMRYxoU2oNLxU450OZdbO4kttW9oZAKm+
         Klw+F2eDtiUeZ5fTO0mjjcakUxL0nZTrX6ETz1c7wHg4USDfVMbfLDlXPSmJmiWYWny7
         rbXRLtsMZNHMpBhyqc0r+ORgbevjyKFSX6i8/sPYCVYb9BRd/iEupCJrbMj53LuVEy8H
         1YxQE06J4ymnXly3ghJWtMlZZTmYMDF175c3Fa1Ty68qVpMc385rjNglWJ5Y+x+MKgFO
         aahC+SAhuMFJRtz5FeK+CNZ2qcfeqPmBjjyKhB6Ss2er589ZxH8LhubfdihkrjHYI7v4
         dLtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793707936; x=1794312736;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/OA40tUqMOdAoYzZGtz7qynGnlFfj2rERGVim4MgYtI=;
        b=WoFy7HIpMAJW42WsZuLxeiGiPMrsssYcqojm+eHqqzdaznKdJHo1uHJ+3cBKthJJ17
         PynhnrY3amjWfYS8yudys5PiCRYPoac+F6O5+os97tPUIMUQ8kOTSkxukRk/5ch0t/8v
         ncux+F1nQCdWt0CW5R3DyqLnsMRiq/PPleRz5aCP3iOyOlCeLXSUsbyFu4upu3E3OPvD
         IBISGlf4asaAueW7zCnAck9cerKjg7LARSypFJpVpSIRqfTJ7qHlqvXb5A0dCrzLmS1o
         R+DeEciyRDipnPXsBtqWsKKXHQSPVacQR/Rv0/QYul1ZT/ruh9Xf1mXrj/YXGcVcAnkS
         cG0A==
X-Gm-Message-State: APuU4Z8AW4LGtBHXLOGDc5n/O/2uF1oYhWK0P4mxQNJyyVANFwSWwGWF
	bUBTBN7/U2pHtoebQocWb6nvwV57K8CI8/BbeK27/Djmx/cZyaojbY0=
X-Gm-Gg: AYBFou00IRU2eyPcnN4nGv/CbjvWIcSQUzGSoFywwlTzjSFnhVS1T9E58bS62348D2+
	fP+aSgzyU2/NtzGyEfwQ61yfZLz7Ke32LehFzU4g1Cf5QLmE97MNeWpgXh25cOL330tb9lCyjs/
	JRn/G9SeJyRG/qLwCfaQX7UWvZU+b/myk6ck3g91d+Df96FrDzeulw+CLfe5erjtvV2+4Ept4PA
	M2cDcmDMcqMK8H84OQPM0WNEin8kA3dpe4aY9XWXurUT4djagvGwdZ45yIPrn7lyaRyz1Z1fQuo
	XlncTmJ6RIrxmXSqcViyxUrE2Tmn6QouhopxDK+xr5UrCVUkc4yM4eV0l1zg7f1BULRXxZ7i8fz
	pHzJvzPVm5CBOZfY63rdB7rc04va7qEO+xwGgRDXgw3pz/3S3F9y7jjshJBwEWajct3QPi2/wF5
	5mDti0NYpEQV99zZsBdZH3di82yruFx9eAkPVRHQKY5OsNKYYuS5k+A4wXiclCnWmJD413n/R2n
	P4JH0lYFFV5kiUCdrNQWWyJnm7N/WxMQWWPZQ1F4zsV2LVo6cDcTrFXsAwMLkfAOu8ylxchGkD4
	R3Y0pWCXrVPV4gKcBsiwNBEiWQWk9TXCnKLzMqOB1vMnMvFqmXM8gUY6os+elE9oJ3Xn7V0/CQ=
	=
X-Received: by 2002:a05:6a21:7701:b0:3e2:6837:3766 with SMTP id adf61e73a8af0-3e928a54acbmr9309268637.61.1793707935673;
        Tue, 03 Nov 2026 04:12:15 -0800 (PST)
Received: from [192.168.1.45] ([45.127.46.119])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8aada3d4092sm3083481b3a.41.2026.11.03.04.12.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 04:12:15 -0800 (PST)
Message-ID: <110601ff-f60d-407f-bfba-05a13c14d490@gmail.com>
Date: Tue, 3 Nov 2026 17:42:11 +0530
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
Subject: Re: [PATCH v4] iio: chemical: ccs811: Make sampling frequency
 configurable
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org
References: <20261101054019.10188-1-nikhilgtr@gmail.com>
 <aunD9kPZ03d8s8AI@ashevche-desk.local>
Content-Language: en-US
From: Nikhil Gautam <nikhilgtr@gmail.com>
In-Reply-To: <aunD9kPZ03d8s8AI@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 03-11-2026 04:52 pm, Andy Shevchenko wrote:
> On Sun, Nov 01, 2026 at 11:10:19AM +0530, Nikhil Gautam wrote:

Hi Andy,
Thanks for the quick review.

>> +static const int ccs811_samp_freq[][2] = {
>> +	{ 1, 0 },
>> +	{ 0, 100000 },
>> +	{ 0, 16667 },
>> +};
> Now it would be better to have a common enum to index above and below.
> So it will be kept in sync
>
> enum {
> 	CCS811_MODE_IAQ_1SEC_IDX,
> 	CCS811_MODE_IAQ_10SEC_IDX,
> 	CCS811_MODE_IAQ_60SEC_IDX,
> };
>
> static const int ccs811_samp_freq[][2] = {
> 	[CCS811_MODE_IAQ_1SEC_IDX] = { 1, 0 },
> 	...
> };
>
>> +/* Drive mode for each entry of ccs811_samp_freq[], same order */
>> +static const u8 ccs811_drive_mode[] = {
>> +	CCS811_MODE_IAQ_1SEC,
>> +	CCS811_MODE_IAQ_10SEC,
>> +	CCS811_MODE_IAQ_60SEC,
>> +};
> ...and here in similar way.
>
> ...
Agreed, a shared index enum is cleaner than relying on "same order".
Will add it and use designated initializers in both tables.

>> +static int ccs811_update_sampling_freq(struct ccs811_data *data,
>> +				       int val, int val2)
>> +{
>> +	u8 drive_mode;
>> +	u8 mode;
>> +	int i, ret;
> Why is 'i' signed? Also keep reversed xmas tree order.
No good reason, Will make it unsigned int and fix the declaration order.

>
> With
>
> 	struct i2c_client *client = data->client;
>
>> +	ret = i2c_smbus_read_byte_data(data->client, CCS811_MEAS_MODE);
> 	ret = i2c_smbus_read_byte_data(client, CCS811_MEAS_MODE);
>
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	mode = (ret & ~CCS811_MODE_MASK) | drive_mode;
>> +	ret = i2c_smbus_write_byte_data(data->client, CCS811_MEAS_MODE,
>> +					mode);
> 	ret = i2c_smbus_write_byte_data(client, CCS811_MEAS_MODE, mode);
Ack, will add the local client pointer and use it in both calls.

>> +static int ccs811_get_sampling_freq(struct ccs811_data *data,
>> +				    int *val, int *val2)
>> +{
>> +	int i;
>> +
>> +	guard(mutex)(&data->lock);
>> +	for (i = 0; i < ARRAY_SIZE(ccs811_drive_mode); i++) {
> 	for (unsigned int i = 0; i < ARRAY_SIZE(ccs811_drive_mode); i++) {
Ack, will use a loop-scoped unsigned int.

>> +static int ccs811_write_raw(struct iio_dev *indio_dev,
>> +			    struct iio_chan_spec const *chan,
>> +			    int val, int val2, long mask)
>> +{
>> +	struct ccs811_data *data = iio_priv(indio_dev);
>> +	int ret;
> Why? I don't see any followup, without which this variable is redundant.
Leftover from the earlier claim/release version.
Will drop it and return ccs811_set_sampling_freq() directly.

Will update comments on next version.


Regards,
Nikhil
