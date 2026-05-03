Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164473CE4BA
	for <linux-iio@vger.kernel.org>; Mon,  4 May 2026 12:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777896409; cv=none; b=mff19sjbpHk8ysRRfyVVp7g1C3SPq2AKNTHeguP+Iq8n3Fd3HiYgwtOLi6tiyTE7qT3GlyAcBP14yrMusrwOr/tHC9oJFaN/XAjO8RUvxgbdGciC97PGqY+uuQdTsAMooXrXXX3xxcFoBOmGhu76hq8WAcVv2wdFuahXlgNIIHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777896409; c=relaxed/simple;
	bh=GCEiLlTsXnV+jOFzAPQyNUpt/HDgQqhhLqJAZlNOitE=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=ATyJCr6DacxlZWBgJStQ2vGxC4DS+ySty9tYe/RhXQ9c1kCQ3Xwgk9ctp/twVAhqnhHer16XDq8CMnQ+aIkAmy39apdf4yN40lLDdIeQSKZrJ94IjRr9kUYvEgnBsTTPrU8Ca+1IWF5Y10xLk/L2sQceBQpfacukuOeVGl1z5VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QOfCM/Mg; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QOfCM/Mg"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3650a4eb605so1474150a91.0
        for <linux-iio@vger.kernel.org>; Mon, 04 May 2026 05:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777896407; x=1778501207; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QcB3rdCurC77Zo0oDMAhChlMWflZi41mjVJjQZ1TOt4=;
        b=QOfCM/MgT4QkVCKK46DQyml3D5MZHqTrIy/wFfxabZXssUNacENGk6xzn0PCHe5DMS
         DR1ax0FngFZxun8H7zsH4XQ4Cb5lGkV9IhrNniqs/92r8t/05DbnjRQC8BC9aeg2/87m
         VJGSczplwJcb32EZfEccwDT7iD2f8iaIHCGEUfeaNYwrc+neV3dcSXyJfAl8dcKjZ4cA
         K06pLHiIB6EHwi4SC1e3uF3HI+AYmJfTtWZKRl2NR++5D2B2flsdCA7DetwGunDx6gc4
         TXDEqLWPRdhmOv4/w7QC7X8oRN39VoJc7+hpC783DOJhzHL8hXhDF/XHEtT5uKGnsW0E
         1Gnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777896407; x=1778501207;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QcB3rdCurC77Zo0oDMAhChlMWflZi41mjVJjQZ1TOt4=;
        b=snyI66C9+Wkf8BeRBHUKAga8KtMZ6xzyad4zwhQzwJ7i8f5Tfs1N1zrcv7Pe+Jkgsl
         FMZRo5g96UvRGDSqowK8pfsWqlzUi2ku5hQcp62TJZG286DRwrswY9S2sZXR/57TyXkU
         j2SQ4vXV64Go69F6+hd/I1Ydn7h06yV6KXZPvXI9adZ2/fJoobinPVwXRMTHqbMPHawM
         s4N967A51i4DXWZsfv4j/thmZGzgjXsjbYtyYzgp3n9gaPlhJVUrcvuEyEogZ3dyEANH
         pNkiirSfa2uAihHGbzf5VJdbqkNckaOE2/mIyq98vj7SnyXRX2xj6sI7O7Q3ukP2ASaC
         uZbA==
X-Forwarded-Encrypted: i=1; AFNElJ9IP7Ymu0ll2efKNYMdto+pKw6WzFBsUFh8rr+xiq4YTR9r39PyvZ07N66rCG+hYxcTAF1eco4GM9A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVlJYsMqcg16YXXn86GHwDpzDBCOLmOb5KPhQ9K9v/0ZbWw9zd
	cAUpTineAMsxu20/hQrbmJldgQTlZX7lXj8sPDN998xwI+0dMN0LpUs6iGA8wg==
X-Gm-Gg: AeBDietHmGsBHSodb1bxOV1Q1QxrutoPF0u5qnsIJyQP7CE2o5Sr0+EUDoCqJiu09mq
	7+LBETBoVvE0dxNhrDCXv8zaxcY9Ea0bKVBxMxPOKVRCwdP3ti52NKZxOj0oFJ2zdaKG5LKYA8q
	gKGOzjYQEB3atTzoxiMR32bLJ7n7pzFbNPs+LQN/XCkQT+bS2uuI97zJvvdeQ26L3Ny3Qf88awO
	VNdmHNVI/tce9doKH3+By0BtZ3XkfCAJKxese88MjD10sAkkAQ/ssxyZqwNBZLvt23lq+rB9Ppq
	eAnqDAjtSQyyvXzl30c82XJjeUkqzJ/KN61CXB0x1Q4cLxMD41ZKDhxksG1taNtN9psFVHcecGc
	XmoDzSnXh9h62CYPEj50ETz9pqwIOozeOVWUhs685kqnmfjLr5esJeGuJbSuX/249VTXlGzSO6d
	cnDMygTnty/6K33ky2phzHCSGb7XuryjFMO5F43KD8P1Ds
X-Received: by 2002:a17:90b:44:b0:35e:3e86:e2d3 with SMTP id 98e67ed59e1d1-3650cdd0a99mr9517579a91.10.1777896407122;
        Mon, 04 May 2026 05:06:47 -0700 (PDT)
Received: from ehlo.thunderbird.net ([2401:4900:53d0:4f0b::e36:44d1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-364ec042370sm11661701a91.17.2026.05.04.05.06.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 May 2026 05:06:46 -0700 (PDT)
Date: Sun, 03 May 2026 20:32:46 +0530
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, mingo@kernel.org,
 christophe.jaillet@wanadoo.fr, nabijaczleweli@nabijaczleweli.xyz,
 kees@kernel.org, kyungmin.park@samsung.com, k.wrona@samsung.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v7_9/9=5D_iio=3A_ssp=5Fsensors=3A_re?=
 =?US-ASCII?Q?use_embedded_RX_buffer_for_SPI_transfers?=
User-Agent: Thunderbird for Android
In-Reply-To: <20260426153154.11bb41c9@jic23-huawei>
References: <20260426091710.3722035-1-sanjayembedded@gmail.com> <20260426091710.3722035-10-sanjayembedded@gmail.com> <20260426153154.11bb41c9@jic23-huawei>
Message-ID: <F00A45E4-EB46-4D55-B533-E2BD329A0513@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 26 April 2026 8:01:54=E2=80=AFpm IST, Jonathan Cameron <jic23@kernel=2E=
org> wrote:
>On Sun, 26 Apr 2026 14:47:10 +0530
>Sanjay Chitroda <sanjayembeddedse@gmail=2Ecom> wrote:
>
>> From: Sanjay Chitroda <sanjayembeddedse@gmail=2Ecom>
>>=20
>> Avoid allocating a temporary DMA buffer in the interrupt context when
>> handling hub-to-AP and AP-to-hub SPI write messages=2E
>>=20
>> Replace the dynamically allocated RX buffer with a fixed-size,
>> preallocated buffer embedded in the driver structure and reused for all
>> SPI receive operations=2E This removes memory allocation from the
>> IRQ path, simplifies lifetime management=2E
>>=20
>> Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail=2Ecom>
>> ---
>> Changes in v6:
>> - Replace dynamically allocated RX buffer with embedded fixed-size buff=
er
>> - Fix struct layout to satisfy DMA alignment constraints comment from D=
avid
>> - v5 change: https://lore=2Ekernel=2Eorg/all/20260406080852=2E2727453-6=
-sanjayembedded@gmail=2Ecom/
>> Changes in v5:
>> - Rebase change on top of latest v5 patch series=2E
>> Changes in v4:
>> - Use preallocated buffer and stash a buffer that gets reused each time=
 instead of a fresh allocation=2E
>> - v3 change: https://lore=2Ekernel=2Eorg/all/20260315125509=2E857195-3-=
sanjayembedded@gmail=2Ecom/
>> Changes in v3:
>> - prepare series to have all respective cleanup API support for the ssp=
_sensors following input from Andy Shevchenko
>> - v2 change: https://lore=2Ekernel=2Eorg/all/20260311174151=2E3441429-1=
-sanjayembedded@gmail=2Ecom/
>> Changes in v2:
>> - split series to individual patch
>> - address review comment from Andy Shevchenko
>> - v1 change: https://lore=2Ekernel=2Eorg/all/20260310200513=2E2162018-3=
-sanjayembedded@gmail=2Ecom/
>> ---
>>  drivers/iio/common/ssp_sensors/ssp=2Eh     |  3 +++
>>  drivers/iio/common/ssp_sensors/ssp_spi=2Ec | 20 ++------------------
>>  2 files changed, 5 insertions(+), 18 deletions(-)
>>=20
>> diff --git a/drivers/iio/common/ssp_sensors/ssp=2Eh b/drivers/iio/commo=
n/ssp_sensors/ssp=2Eh
>> index f649cdecc277=2E=2E8295bb7062a3 100644
>> --- a/drivers/iio/common/ssp_sensors/ssp=2Eh
>> +++ b/drivers/iio/common/ssp_sensors/ssp=2Eh
>> @@ -174,6 +174,7 @@ struct ssp_sensorhub_info {
>>   * @pending_list:	pending list for messages queued to be sent/read
>>   * @sensor_devs:	registered IIO devices table
>>   * @enable_refcount:	enable reference count for wdt (watchdog timer)
>> + * @rx_buf:		buffer to receive SPI data
>>   * @header_buffer:	cache aligned buffer for packet header
>>   */
>>  struct ssp_data {
>> @@ -221,6 +222,8 @@ struct ssp_data {
>>  	struct iio_dev *sensor_devs[SSP_SENSOR_MAX];
>>  	atomic_t enable_refcount;
>> =20
>> +	u8 rx_buf[SSP_DATA_PACKET_SIZE];
>
>Whilst the define exists for this size, do we have anything to confirm it=
 is right?
>It wasn't previously used for anything so is a bit high risk=2E
>
Nothing specific to confirm, I'm assuming this macro and value is added du=
ring development so must be specificing as per technical or reference manua=
l for the SSP firmware protocol=2E

Although, we can plan to add check as pre-change like below:

if (length -> sizeof(data->rx_buf)
     return -EINVAL;


>Also, why doesn't it need to be DMA safe?  I'd expect it either after the=
 following buffer
>or with a __aligned(IIO_DMA_MINALIGN) marking in which case the one below=
 isn't used=2E
>
I will make it=20
u8 rx_buf[SSP_DATA_PACKET_SIZE] __aligned(IIO_DMA_MINALIGN);
>
>> +
>>  	__le16 header_buffer[SSP_HEADER_BUFFER_SIZE / sizeof(__le16)] __align=
ed(IIO_DMA_MINALIGN);
>>  };
>> =20
>> diff --git a/drivers/iio/common/ssp_sensors/ssp_spi=2Ec b/drivers/iio/c=
ommon/ssp_sensors/ssp_spi=2Ec
>> index 870214551f0b=2E=2Ee41da88bf96d 100644
>> --- a/drivers/iio/common/ssp_sensors/ssp_spi=2Ec
>> +++ b/drivers/iio/common/ssp_sensors/ssp_spi=2Ec
>> @@ -339,7 +339,7 @@ static int ssp_parse_dataframe(struct ssp_data *dat=
a, char *dataframe, int len)
>>  /* threaded irq */
>>  int ssp_irq_msg(struct ssp_data *data)
>>  {
>> -	char *buffer;
>> +	char *buffer =3D data->rx_buf;
>
>Put this in inline=2E The local variable may reduce code churn but
>it also hides the important info that this is not locally allocated=2E
>
Agree, will update=2E

>>  	u8 msg_type;
>>  	int ret;
>>  	u16 length, msg_options;
>> @@ -383,19 +383,12 @@ int ssp_irq_msg(struct ssp_data *data)
>>  			 * but the slave should not send such ones - it is to
>>  			 * check but let's handle this
>>  			 */
>> -			buffer =3D kmalloc(length, GFP_KERNEL | GFP_DMA);
>> -			if (!buffer) {
>> -				ret =3D -ENOMEM;
>> -				goto _unlock;
>> -			}
>> =20
>>  			/* got dead packet so it is always an error */
>>  			ret =3D spi_read(data->spi, buffer, length);
>>  			if (ret >=3D 0)
>>  				ret =3D -EPROTO;
>> =20
>> -			kfree(buffer);
>> -
>>  			dev_err(SSP_DEV, "No match error %x\n",
>>  				msg_options);
>> =20
>> @@ -428,22 +421,13 @@ int ssp_irq_msg(struct ssp_data *data)
>>  		mutex_unlock(&data->pending_lock);
>>  		break;
>>  	case SSP_HUB2AP_WRITE:
>> -		buffer =3D kzalloc(length, GFP_KERNEL | GFP_DMA);
>> -		if (!buffer)
>> -			return -ENOMEM;
>> -
>>  		ret =3D spi_read(data->spi, buffer, length);
>>  		if (ret < 0) {
>>  			dev_err(SSP_DEV, "spi read fail\n");
>> -			kfree(buffer);
>>  			break;
>>  		}
>> =20
>> -		ret =3D ssp_parse_dataframe(data, buffer, length);
>> -
>> -		kfree(buffer);
>> -		break;
>> -
>> +		return ssp_parse_dataframe(data, buffer, length);
>
>This now makes this path different from the other switch legs=2E
>I would precede this patch with one doing direct returns from
>all the legs in here=2E  Then this just becomes an obvious update
>in this patch=2E
>
I will precede a patch to update all the legs in switch=2E

>>  	default:
>>  		dev_err(SSP_DEV, "unknown msg type\n");
>>  		return -EPROTO;
>
