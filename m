Return-Path: <jic23@jic23.retrosnub.co.uk>
In-Reply-To: <6c946d3c9f99f1d4eb44294311078be5.squirrel@mungewell.org>
References: <2d05200efc42012bd16be4dde0fad85d.squirrel@mungewell.org> <A077DCB2-204C-40BC-881D-83CAEF418A6C@kernel.org> <6c946d3c9f99f1d4eb44294311078be5.squirrel@mungewell.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: ST driver - ad-hoc allocation of trigger interrupt
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Date: Fri, 19 Jun 2015 17:29:51 +0100
To: simon@mungewell.org,Jonathan Cameron <jic23@kernel.org>
CC: linux-iio@vger.kernel.org
Message-ID: <02C8D26D-1C35-4E76-A1A8-4232A457D55C@jic23.retrosnub.co.uk>
List-ID: <linux-iio@vger.kernel.org>



On 18 June 2015 21:53:53 BST, simon@mungewell.org wrote:
>
>>>The story of our attempt is documented here:
>>>https://groups.google.com/forum/?hl=en#!topic/richards-tech-user-forum/BjQpWjTmims
>>>
>>>Any suggestions on how we can succeed?
>>
>> Looks like you basically got there with the DT file at the end. Adhoc
>> arrangements
>>  like this are often done with device tree overlays (which can be
>added to
>> a
>>  running device). A quick Google suggests the raspberry pi uses these
>for
>> standard hats.
>
>A little follow-up that you might like; Richard was able to get the IIO
>devices configured via Device Tree, even to the point of getting a full
>sensor fusion working to give pose and heading.
>
>https://richardstechnotes.wordpress.com/2015/06/17/rteiioimu-driving-a-9-dof-imu-via-industrial-io-iio/
>
>Simon.
Nice.

Thanks for the heads up!
>
>--
>To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
