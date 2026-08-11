Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79F5283FCF
	for <linux-iio@vger.kernel.org>; Tue, 11 Aug 2026 00:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786407900; cv=none; b=Be8Pvl4eSZ3ltzTgNEHk4wwV68UcsmWxyMVGo7Zl61JaV5iIg/FaNnsPjHh6+LidyBJIhawf/JFFyzskAwHJkoBi8DDX95YF2Xut0Cdq2JH22CbrBH28X275q7uNFg/fXBC00cvCTE0tmYVFcT7wUzejCQwjhZVBJ3oxDbYbYVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786407900; c=relaxed/simple;
	bh=iX8FFqvtgYMboA36Jc6YfVmIK8tlSTF/513CLXcRrAs=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:In-Reply-To:Subject:
	 From:To:References; b=hjIR6HCfvhMeioBHzN1oy6CBheKE5mDssAVSvKjnmOknlKCthXBW2P01/+RI9/aQIrTQSxpvupqFdM8Q7uAbM4VkF5KJBLVVwxcynITW2qf5m1XUTDcu5oxfDoy9YaDu0zCIPoUaMC+lb9bY+q9TYciOVCitle5i3VzAm8qVj28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=maxwelld.cc; spf=pass smtp.mailfrom=maxwelld.cc; dkim=pass (2048-bit key) header.d=maxwelld.cc header.i=@maxwelld.cc header.b=VV8Y3Ybe; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=Srn8NIQa; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=maxwelld.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maxwelld.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maxwelld.cc header.i=@maxwelld.cc header.b="VV8Y3Ybe";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="Srn8NIQa"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=VV8Y3Ybeg8/8rl0mx1zF0t4h8LBCT0Qzu0vM9QyshOQ8R3jaw28p+HwAig+Jo2obLrfTCKD/pFr+1wejROaMWCKI6DfjX0rxKmoHmUF4O9qmgRdTZqJqj3uqA7qfJjrs+z3pZNPeyCj194Xz2jXqBiDTdSkulFyEdRAI8lEB2n5tLozRL994Pl1N8zF+sxBd2G2RjzbUQXKyAntuCZ7NlpGZ7fq2qCdGzpQMZhfjnNTx7Rui8QEXfYasiqiHyWmNsLIetATB3JZ8yUuymIJRuqSA4GWUwO7amfkeEwctFP0fLWDqmMnJrBV3sUh7WM6ijxJZnuqAK2vY9CUvPLDG4Q==; s=purelymail2; d=maxwelld.cc; v=1; bh=iX8FFqvtgYMboA36Jc6YfVmIK8tlSTF/513CLXcRrAs=; h=Received:Date:Subject:From:To;
DKIM-Signature: a=rsa-sha256; b=Srn8NIQa1HgGMhnkxwE6XgphPiOYDnmgKHCgdAQbOAfdlfmmtcYa1yafyURA2xBprX3y1mowscvkNzicHH5jnBhK4ZsxvySqD7MvQRoGTkMiUtvJ6OVjW6bQLk2ZkEFMCPFCR7hxVdADCIS9PUL406S0niixOplpAix90+57bkYbOoCw7qGyXKhwhX8LH9JptyhoRitEGi6aZ19nSaWvPG4krCL10PK8SsBGUne8nyNYLdNjMKGUP+SLcAp3P1ohrhP+dFYshGW2vnVfVrQIaNOQLCdiRh1HpXFt+135aN1ZCO9gN+64fqg/LEKy5r0BWzyLuBVBhNCw3NG0hKaz5g==; s=purelymail2; d=purelymail.com; v=1; bh=iX8FFqvtgYMboA36Jc6YfVmIK8tlSTF/513CLXcRrAs=; h=Feedback-ID:Received:Date:Subject:From:To;
Feedback-ID: 1013395:40550:null:purelymail
X-Pm-Original-To: linux-iio@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1995615954;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Tue, 11 Aug 2026 00:24:33 +0000 (UTC)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 10 Aug 2026 19:24:32 -0500
Message-Id: <DKLOQNAMLRWA.20JM0MR23ECCK@maxwelld.cc>
Cc: "Jonathan Cameron" <jic23@kernel.org>, "Wadim Mueller"
 <wafgo01@gmail.com>, "David Lechner" <dlechner@baylibre.com>,
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy Shevchenko"
 <andy@kernel.org>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
In-Reply-To: <b61d786c-9200-46c6-9072-d7c43639b6b5@kylinos.cn>
Subject: Re: [PATCH] iio: flow: slf3s: restart measurement if VDD disable
 fails
From: "Maxwell Doose" <maxwell@maxwelld.cc>
To: "Linmao Li" <lilinmao@kylinos.cn>, "Maxwell Doose" <maxwell@maxwelld.cc>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260805110255.504576-1-lilinmao@kylinos.cn>
 <CAKqfh0G82W5wWg2xMs_qRcUAWCk1Uq1BXTPAD885h6k8sJi8Gw@mail.gmail.com>
 <b61d786c-9200-46c6-9072-d7c43639b6b5@kylinos.cn>

On Wed Aug 5, 2026 at 9:21 PM CDT
Linmao Li <lilinmao@kylinos.cn> wrote:

>
> =E5=9C=A8 2026/8/6 0:45, Maxwell Doose =E5=86=99=E9=81=93:
>> On Wed, Aug 5, 2026 at 6:07=E2=80=AFAM Linmao Li <lilinmao@kylinos.cn> w=
rote:
>>> slf3s_suspend() stops continuous measurement before disabling VDD. If
>>> regulator_disable() fails while the supply remains enabled, the system
>>> sleep transition is aborted. Since the PM core does not call the
>>> corresponding resume callback for a device whose suspend callback faile=
d,
>>> the sensor remains idle after the system returns to the running state a=
nd
>>> subsequent reads fail.
>>>
>>> Attempt to restart continuous measurement on this error path. Preserve =
the
>>> regulator error and warn if restarting the measurement also fails.
>>>
>>> Fixes: d240b0b8a1ce ("iio: flow: add Sensirion SLF3S liquid flow sensor=
 driver")
>>> Signed-off-by: Linmao Li <lilinmao@kylinos.cn>
>>> ---
>>>   drivers/iio/flow/slf3s.c | 12 +++++++++++-
>>>   1 file changed, 11 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/iio/flow/slf3s.c b/drivers/iio/flow/slf3s.c
>>> index dfa7c14090454..75ee82fbd3295 100644
>>> --- a/drivers/iio/flow/slf3s.c
>>> +++ b/drivers/iio/flow/slf3s.c
>>> @@ -462,6 +462,7 @@ static int slf3s_suspend(struct device *dev)
>>>   {
>>>          struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
>>>          struct slf3s_data *sf =3D iio_priv(indio_dev);
>>> +       int restart_ret;
>>>          int ret;
>>>
>>>          guard(mutex)(&sf->lock);
>>> @@ -470,7 +471,16 @@ static int slf3s_suspend(struct device *dev)
>>>          if (ret)
>>>                  return ret;
>>>
>>> -       return regulator_disable(sf->vdd);
>>> +       ret =3D regulator_disable(sf->vdd);
>>> +       if (!ret)
>>> +               return 0;
>>> +
>>> +       restart_ret =3D slf3s_start_meas(sf, sf->medium);
>>> +       if (restart_ret)
>>> +               dev_warn(dev, "failed to restart measurement after susp=
end failure: %d\n",
>>> +                        restart_ret);
>>> +
>>> +       return ret;
>>>   }
>>>
>> In addition to David's question, why reenable vs keep it sleeping (and
>> why don't we dev_warn() after regulator disable failure)?
> Because a failed suspend callback means the device never gets its resume
> callback, so nothing would restart the measurement.=C2=A0 And as the comm=
ent
> in probe() says, a stop command sent to an already idle sensor errors
> out - slf3s_suspend() returns that error - so every later system suspend
> would fail as well.
>

I see. This ought to give me an excuse to look into PM stuff :)

>
> No dev_warn() on the regulator error because it is the return value and
> the PM core already logs it.=C2=A0 Happy to add one if you prefer.
>

Since the PM core already logs it let's go no dev_warn().

>
> One thing I noticed while doing this, not specific to my patch: the
> datasheets for all three supported variants say that after the stop
> command the sensor "needs up to 0.5 ms to power down the heater, enter
> idle mode and be receptive for a new command".=C2=A0 probe() and
> slf3s_set_medium() both send the next command right away, and my
> rollback can too.=C2=A0 Is that something you have had to care about in
>
> practice?
>

Perhaps something that would be good to test on actual hardware to see
if it matters. Maybe Wadim can check? However in all of the (very very
basic) drivers I've written I've tried my best to account for hardware
delays so I would do some more research into this.

thanks,
max
