Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wg0-f43.google.com ([74.125.82.43]:33388 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750781AbaKYQGF (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 25 Nov 2014 11:06:05 -0500
Received: by mail-wg0-f43.google.com with SMTP id l18so1262873wgh.30
        for <linux-iio@vger.kernel.org>; Tue, 25 Nov 2014 08:06:03 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <54739462.7060300@gmx.de>
References: <1416246966-3083-1-git-send-email-octavian.purdila@intel.com>
	<1416246966-3083-7-git-send-email-octavian.purdila@intel.com>
	<5472688D.9010801@gmx.de>
	<CAE1zotKM30FQ1ScrEiPGW4SuLvjTUVpj4eg0wpCLY=UVU_UHxw@mail.gmail.com>
	<54739462.7060300@gmx.de>
Date: Tue, 25 Nov 2014 18:06:03 +0200
Message-ID: <CAE1zot+3SqOYUhrTsMK+1njkTWVuReTJeCQMcYHQDaSr=UA0qA@mail.gmail.com>
Subject: Re: [RFC 6/8] iio: bmc150: introduce bmc150_accel_trigger
From: Octavian Purdila <octavian.purdila@intel.com>
To: Hartmut Knaack <knaack.h@gmx.de>
Cc: linux-iio@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@intel.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, Nov 24, 2014 at 10:26 PM, Hartmut Knaack <knaack.h@gmx.de> wrote:
> Octavian Purdila schrieb am 24.11.2014 11:42:
>> On Mon, Nov 24, 2014 at 1:06 AM, Hartmut Knaack <knaack.h@gmx.de> wrote:
>>>> +
>>>> +static void bmc150_accel_unregister_triggers(struct bmc150_accel_data *data,
>>>> +                                          int from)
>>>> +{
>>>> +     int i;
>>>> +
>>>> +     for (i = from; i >= 0; i++) {
>>>> +             if (data->triggers[i].indio_trig) {
>>>> +                     iio_trigger_unregister(data->triggers[i].indio_trig);
>>>> +                     data->triggers[i].indio_trig = NULL;
>>> Better use devm_iio_trigger_free()?
>>
>> Wouldn't that be called anyway a little bit later?
>
> I thought it would be cleaner/safer to release it using the opposite of devm_iio_trigger_alloc(), instead of changing its reference to NULL.

I thought bmc150_accel_unregister_triggers could be called twice, but
reviewing the code again I see that can't happen. I guess I can remove
the NULL assignment altogether.
