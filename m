Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wg0-f54.google.com ([74.125.82.54]:46570 "EHLO
	mail-wg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752124AbaKWWYT (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 23 Nov 2014 17:24:19 -0500
Received: by mail-wg0-f54.google.com with SMTP id l2so293532wgh.27
        for <linux-iio@vger.kernel.org>; Sun, 23 Nov 2014 14:24:18 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <54725972.7090104@gmx.de>
References: <1416246966-3083-1-git-send-email-octavian.purdila@intel.com>
	<1416246966-3083-4-git-send-email-octavian.purdila@intel.com>
	<54725972.7090104@gmx.de>
Date: Mon, 24 Nov 2014 00:24:18 +0200
Message-ID: <CAE1zotJeZWrzAyvf-ic9ez-Gih_hoZ9+8HeMr+PVqBVBKmAjVQ@mail.gmail.com>
Subject: Re: [RFC 3/8] iio: bmc150: refactor interrupt enabling
From: Octavian Purdila <octavian.purdila@intel.com>
To: Hartmut Knaack <knaack.h@gmx.de>
Cc: linux-iio@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@intel.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, Nov 24, 2014 at 12:02 AM, Hartmut Knaack <knaack.h@gmx.de> wrote:

>> +static int bmc150_accel_set_interrupt(struct bmc150_accel_data *data,
>> +                                   struct bmc150_accel_interrupt_info *info,
>> +                                   bool state)
>> +{
>> +     int ret;
>> +
>> +     /*
>> +      * We will expect the enable and disable to do operation in
>> +      * in reverse order. This will happen here anyway as our
>> +      * resume operation uses sync mode runtime pm calls, the
>> +      * suspend operation will be delayed by autosuspend delay
>> +      * So the disable operation will still happen in reverse of
>> +      * enable operation. When runtime pm is disabled the mode
>> +      * is always on so sequence doesn't matter
>> +      */
>> +     ret = bmc150_accel_set_power_state(data, state);
>> +     if (ret < 0)
>> +             return ret;
>> +
>> +
>> +     /* map the interrupt to the appropriate pins */
>> +     if (info->map_reg) {
> So, info->map_reg might be set, but info->en_reg will always be set?

Good catch, originally I thought map_reg may not be needed, but it
looks like it is not needed after all. I will remove the if in the
next version.

>> +
>> +static int bmc150_accel_setup_any_motion_interrupt(
>> +                                     struct bmc150_accel_data *data,
>> +                                     bool status)
>> +{
>> +     return bmc150_accel_set_interrupt(data, &bmc150_accel_interrupts[1],
>> +                                       status);
>> +}
>> +
>> +static int bmc150_accel_setup_new_data_interrupt(struct bmc150_accel_data *data,
>> +                                        bool status)
>> +{
>> +     return bmc150_accel_set_interrupt(data, &bmc150_accel_interrupts[0],
>> +                                       status);
>> +}
>> +
> I don't think these wrappers really provide a benefit.

They are removed in one of the later patches. I wanted to keep this
patch small, hence I kept the two original functions in this patch.
