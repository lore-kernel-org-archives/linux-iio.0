Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:38712 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751018AbdCQNcl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 Mar 2017 09:32:41 -0400
Date: Fri, 17 Mar 2017 13:31:13 +0000
In-Reply-To: <1489756594.18490.22.camel@hadess.net>
References: <1489659652-35608-1-git-send-email-hongyan.song@intel.com> <1489716812.10281.4.camel@intel.com> <1489756594.18490.22.camel@hadess.net>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Subject: Re: [PATCH] iio: hid: hid-sensor-accel-3d: Add second ACC sensor support
To: Bastien Nocera <hadess@hadess.net>,
        "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "Song, Hongyan" <hongyan.song@intel.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC: "jikos@kernel.org" <jikos@kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Message-ID: <3CBCE111-2686-4B23-9CB2-E9888FE6427D@jic23.retrosnub.co.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On 17 March 2017 13:16:34 GMT+00:00, Bastien Nocera <hadess@hadess.net> wrote:
>On Fri, 2017-03-17 at 02:13 +0000, Pandruvada, Srinivas wrote:
>> On Thu, 2017-03-16 at 18:20 +0800, Song Hongyan wrote:
>> > As accelerometer sensor becomes more and more popular, there are
>> > more
>> > user scenarios have been developed, "Hinge" is a very important
>> > usecase
>> > which needs two accelerometer sensors to calculate the included
>> > angle
>> > of keyboard and screen.
>> > In this case, two accelerometer sensors will be exposed. Currently,
>> > IIO interface hasn't other way to distinguish two sensors with same
>> > sensor type, except sensor name. So a new sensor name
>> > "accel_2nd_3d"
>> > is added for secondary accelerometer sensor.
>> 
>> This type of interface will not satisfy all cases. We have some hubs
>> with  many accelerometers attached. Same case is also true even for
>> discrete sensors. So there should be some framework way to expose
>> location of sensors.
>
>So you're nacking as well?
>
>> ACPI has special method called _PLD (Physical Device Location), which
>> can  be used to specify location of any device. So we need to be able
>> to export such information to user space. We can add for each sensor
>> the location information.
>> 
>> I can propose some ABI for exporting location information.
>
>There were patches floating around to do this, but they were never
>finished:
>http://www.spinics.net/lists/linux-acpi/msg51540.html

We have the location element as defined for the cross_ec sensors.  Taking that general would be fine with me.

 Current options are base and lid, but can be extended to include more.

J
>
>Cheers
>--
>To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
