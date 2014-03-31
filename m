Return-Path: <nyt@countercultured.net>
Message-ID: <5338E767.2020107@countercultured.net>
Date: Sun, 30 Mar 2014 23:56:23 -0400
From: Rob Mosher <nyt@countercultured.net>
MIME-Version: 1.0
To: Zubair Lutfullah <zubair.lutfullah@gmail.com>
CC: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 robertcnelson@gmail.com, Samuel Ortiz <sameo@linux.intel.com>,
 Jonathan Cameron <jic23@kernel.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Felipe Balbi <balbi@ti.com>,
 linux-iio@vger.kernel.org, linux-input@vger.kernel.org, balbi@ti.com,
 Lee Jones <lee.jones@linaro.org>
Subject: Re: ti_am33x_adc sampling bugs
References: <53379DF2.7050004@rznt.com> <5337B3F4.30500@countercultured.net> <CAExKytzRv4CT9zTor=-fc5Mfv+xG9uTjQP=LWosVnhEHsa9Y0A@mail.gmail.com>
In-Reply-To: <CAExKytzRv4CT9zTor=-fc5Mfv+xG9uTjQP=LWosVnhEHsa9Y0A@mail.gmail.com>
Content-Type: multipart/alternative;
 boundary="------------060902080204030809050302"
List-ID: <linux-iio@vger.kernel.org>

This is a multi-part message in MIME format.
--------------060902080204030809050302
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

The specified patch is already included.  The system was running the 
latest kernel from Robert Nelson's repo.  Any suggestions?  I'll try 
removing some of the patches to see if it fixes this behavior.  I have a 
feeling I know which one is doing it.

Thanks.

output from running patch.sh with source pulled from 
https://github.com/beagleboard/kernel/tree/3.8

/home/bbuild/comp/kernel/patches/adc/0017-IIO-ADC-ti_adc-Fix-1st-sample-read.patch: 
applied

Just in case, I built and installed the kernel and the same behavior 
persisted.

root@rbone:/# uname -a
Linux rbone 3.8.13-00737-g7dfad77 #1 SMP Sun Mar 30 22:11:44 EDT 2014 
armv7l GNU/Linux

gpio30 is connected to AIN4 using a voltage divider

root@rbone:/# cd /sys/class/gpio/
root@rbone:/sys/class/gpio# echo 30 > export
root@rbone:/sys/class/gpio# echo BB-ADC > /sys/devices/bone_capemgr.9/slots
root@rbone:/sys/class/gpio# cd /sys/devices/ocp.3/helper.11/
root@rbone:/sys/devices/ocp.3/helper.11# echo out > 
/sys/class/gpio/gpio30/direction

root@rbone:/sys/devices/ocp.3/helper.11# echo 1 > 
/sys/class/gpio/gpio30/value
root@rbone:/sys/devices/ocp.3/helper.11# cat AIN4
1460

root@rbone:/sys/devices/ocp.3/helper.11# echo 0 > 
/sys/class/gpio/gpio30/value
root@rbone:/sys/devices/ocp.3/helper.11# cat AIN4
0

root@rbone:/sys/devices/ocp.3/helper.11# grep . AIN[0-3] AIN[5-7]
AIN0:1550
AIN1:1213
AIN2:1485
AIN3:795
AIN5:513
AIN6:744
AIN7:1698

root@rbone:/sys/devices/ocp.3/helper.11# echo 1 > 
/sys/class/gpio/gpio30/value
root@rbone:/sys/devices/ocp.3/helper.11# cat AIN4
0
root@rbone:/sys/devices/ocp.3/helper.11# cat AIN4
0
root@rbone:/sys/devices/ocp.3/helper.11# cat AIN4
0
root@rbone:/sys/devices/ocp.3/helper.11# cat AIN4
0
root@rbone:/sys/devices/ocp.3/helper.11# cat AIN4
0
root@rbone:/sys/devices/ocp.3/helper.11# cat AIN4
0
root@rbone:/sys/devices/ocp.3/helper.11# cat AIN4
1460

On 3/30/2014 9:16 AM, Zubair Lutfullah wrote:
> https://github.com/beagleboard/kernel/blob/3.8/patches/adc/0017-IIO-ADC-ti_adc-Fix-1st-sample-read.patch
> IIRC, this patch fixes this issue
>
> Can you compile the kernel from the sources and check?
> https://github.com/beagleboard/kernel/tree/3.8
>
> Regards
> ZubairLK
>
> On Sun, Mar 30, 2014 at 7:04 AM, Rob Mosher <nyt@countercultured.net 
> <mailto:nyt@countercultured.net>> wrote:
>
>     Just a note, the same behavior persists with BB-ADC dtb and
>     reading from in_voltage4_raw
>
>
>     On 3/30/2014 12:30 AM, Rob Mosher wrote:
>
>         Hello fine developers,
>
>         It seems I've stumbled upon a problem while developing a full
>         featured Ruby gem for the Beaglebone.
>
>         It seems a patch included in the beaglebone kernel causes some
>         issues while reading analog inputs.  Apparently the samples
>         get backlogged by the number of adc pins in use.  I'm not sure
>         which patch exactly as there are a number that affect adc
>         buffering and I'm not currently setup for kernel building,
>         however the below output should detail the problem.
>
>         Using the official Debian image.
>         Linux rbone 3.8.13-bone43 #1 SMP Wed Mar 26 14:21:39 UTC 2014
>         armv7l GNU/Linux
>
>         Distributor ID: Debian
>         Description:    Debian GNU/Linux 7.4 (wheezy)
>         Release:        7.4
>         Codename:       wheezy
>
>         root@rbone:~# echo cape-bone-iio >
>         /sys/devices/bone_capemgr.9/slots
>
>         This is the normal and expected behavior.
>
>         1.8v applied to AIN4
>         root@rbone:/sys/devices/ocp.3/helper.12# cat AIN4
>         1798
>
>         0v applied to AIN4
>         root@rbone:/sys/devices/ocp.3/helper.12# cat AIN4
>         0
>
>         1.8v applied to AIN4
>         root@rbone:/sys/devices/ocp.3/helper.12# cat AIN4
>         1798
>
>         0v applied to AIN4
>         root@rbone:/sys/devices/ocp.3/helper.12# cat AIN4
>         0
>
>         So far working as intended....  Now reading from the other pins.
>
>         root@rbone:/sys/devices/ocp.3/helper.12# grep . AIN[0-3] AIN[5-7]
>         AIN0:1563
>         AIN1:1221
>         AIN2:1487
>         AIN3:789
>         AIN5:514
>         AIN6:743
>         AIN7:1698
>
>         Now applying 1.8v to AIN4
>         root@rbone:/sys/devices/ocp.3/helper.12# cat AIN4
>         0
>         root@rbone:/sys/devices/ocp.3/helper.12# cat AIN4
>         0
>         root@rbone:/sys/devices/ocp.3/helper.12# cat AIN4
>         0
>         root@rbone:/sys/devices/ocp.3/helper.12# cat AIN4
>         0
>         root@rbone:/sys/devices/ocp.3/helper.12# cat AIN4
>         0
>         root@rbone:/sys/devices/ocp.3/helper.12# cat AIN4
>         0
>         root@rbone:/sys/devices/ocp.3/helper.12# cat AIN4
>         1798
>
>         Now applying 0v to AIN4
>
>         root@rbone:/sys/devices/ocp.3/helper.12# cat AIN4
>         1460
>         root@rbone:/sys/devices/ocp.3/helper.12# cat AIN4
>         1798
>         root@rbone:/sys/devices/ocp.3/helper.12# cat AIN4
>         1798
>         root@rbone:/sys/devices/ocp.3/helper.12# cat AIN4
>         1460
>         root@rbone:/sys/devices/ocp.3/helper.12# cat AIN4
>         1460
>         root@rbone:/sys/devices/ocp.3/helper.12# cat AIN4
>         1460
>         root@rbone:/sys/devices/ocp.3/helper.12# cat AIN4
>         0
>
>
>
>         And another example, showing relation to the number of pins in
>         use.
>
>         1.8v to AIN4
>         root@rbone:/sys/devices/ocp.3/helper.12# cat AIN4
>         1460
>         root@rbone:/sys/devices/ocp.3/helper.12# grep . AIN[0-3]
>         AIN0:1697
>         AIN1:1298
>         AIN2:1524
>         AIN3:816
>         root@rbone:/sys/devices/ocp.3/helper.12# cat AIN4
>         1798
>
>         0v to AIN4
>         root@rbone:/sys/devices/ocp.3/helper.12# cat AIN4
>         1798
>         root@rbone:/sys/devices/ocp.3/helper.12# cat AIN4
>         1460
>         root@rbone:/sys/devices/ocp.3/helper.12# cat AIN4
>         1460
>         root@rbone:/sys/devices/ocp.3/helper.12# cat AIN4
>         1460
>         root@rbone:/sys/devices/ocp.3/helper.12# cat AIN4
>         0
>
>         1.8v to AIN4
>         root@rbone:/sys/devices/ocp.3/helper.12# cat AIN4
>         0
>         root@rbone:/sys/devices/ocp.3/helper.12# cat AIN4
>         0
>         root@rbone:/sys/devices/ocp.3/helper.12# cat AIN4
>         0
>         root@rbone:/sys/devices/ocp.3/helper.12# cat AIN4
>         0
>         root@rbone:/sys/devices/ocp.3/helper.12# cat AIN4
>         1798
>
>         -- 
>         Rob Mosher
>         Senior Network and Software Engineer
>         Hurricane Electric / AS6939
>
>
>
>
>


--------------060902080204030809050302
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=ISO-8859-1"
      http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    The specified patch is already included.&nbsp; The system was running the
    latest kernel from Robert Nelson's repo.&nbsp; Any suggestions?&nbsp; I'll try
    removing some of the patches to see if it fixes this behavior.&nbsp; I
    have a feeling I know which one is doing it.<br>
    <br>
    Thanks.<br>
    <br>
    output from running patch.sh with source pulled from <a
      moz-do-not-send="true"
      href="https://github.com/beagleboard/kernel/tree/3.8">https://github.com/beagleboard/kernel/tree/3.8</a><br>
    <br>
    /home/bbuild/comp/kernel/patches/adc/0017-IIO-ADC-ti_adc-Fix-1st-sample-read.patch:
    applied<br>
    <br>
    Just in case, I built and installed the kernel and the same behavior
    persisted.<br>
    <br>
    root@rbone:/# uname -a<br>
    Linux rbone 3.8.13-00737-g7dfad77 #1 SMP Sun Mar 30 22:11:44 EDT
    2014 armv7l GNU/Linux<br>
    <br>
    gpio30 is connected to AIN4 using a voltage divider<br>
    <br>
    root@rbone:/# cd /sys/class/gpio/<br>
    root@rbone:/sys/class/gpio# echo 30 &gt; export<br>
    root@rbone:/sys/class/gpio# echo BB-ADC &gt;
    /sys/devices/bone_capemgr.9/slots<br>
    root@rbone:/sys/class/gpio# cd /sys/devices/ocp.3/helper.11/<br>
    <a class="moz-txt-link-abbreviated" href="mailto:root@rbone:/sys/devices/ocp.3/helper.11#">root@rbone:/sys/devices/ocp.3/helper.11#</a> echo out &gt;
    /sys/class/gpio/gpio30/direction<br>
    <br>
    <a class="moz-txt-link-abbreviated" href="mailto:root@rbone:/sys/devices/ocp.3/helper.11#">root@rbone:/sys/devices/ocp.3/helper.11#</a> echo 1 &gt;
    /sys/class/gpio/gpio30/value<br>
    <a class="moz-txt-link-abbreviated" href="mailto:root@rbone:/sys/devices/ocp.3/helper.11#">root@rbone:/sys/devices/ocp.3/helper.11#</a> cat AIN4<br>
    1460<br>
    <br>
    <a class="moz-txt-link-abbreviated" href="mailto:root@rbone:/sys/devices/ocp.3/helper.11#">root@rbone:/sys/devices/ocp.3/helper.11#</a> echo 0 &gt;
    /sys/class/gpio/gpio30/value<br>
    <a class="moz-txt-link-abbreviated" href="mailto:root@rbone:/sys/devices/ocp.3/helper.11#">root@rbone:/sys/devices/ocp.3/helper.11#</a> cat AIN4<br>
    0<br>
    <br>
    <a class="moz-txt-link-abbreviated" href="mailto:root@rbone:/sys/devices/ocp.3/helper.11#">root@rbone:/sys/devices/ocp.3/helper.11#</a> grep . AIN[0-3] AIN[5-7]<br>
    AIN0:1550<br>
    AIN1:1213<br>
    AIN2:1485<br>
    AIN3:795<br>
    AIN5:513<br>
    AIN6:744<br>
    AIN7:1698<br>
    <br>
    <a class="moz-txt-link-abbreviated" href="mailto:root@rbone:/sys/devices/ocp.3/helper.11#">root@rbone:/sys/devices/ocp.3/helper.11#</a> echo 1 &gt;
    /sys/class/gpio/gpio30/value<br>
    <a class="moz-txt-link-abbreviated" href="mailto:root@rbone:/sys/devices/ocp.3/helper.11#">root@rbone:/sys/devices/ocp.3/helper.11#</a> cat AIN4<br>
    0<br>
    <a class="moz-txt-link-abbreviated" href="mailto:root@rbone:/sys/devices/ocp.3/helper.11#">root@rbone:/sys/devices/ocp.3/helper.11#</a> cat AIN4<br>
    0<br>
    <a class="moz-txt-link-abbreviated" href="mailto:root@rbone:/sys/devices/ocp.3/helper.11#">root@rbone:/sys/devices/ocp.3/helper.11#</a> cat AIN4<br>
    0<br>
    <a class="moz-txt-link-abbreviated" href="mailto:root@rbone:/sys/devices/ocp.3/helper.11#">root@rbone:/sys/devices/ocp.3/helper.11#</a> cat AIN4<br>
    0<br>
    <a class="moz-txt-link-abbreviated" href="mailto:root@rbone:/sys/devices/ocp.3/helper.11#">root@rbone:/sys/devices/ocp.3/helper.11#</a> cat AIN4<br>
    0<br>
    <a class="moz-txt-link-abbreviated" href="mailto:root@rbone:/sys/devices/ocp.3/helper.11#">root@rbone:/sys/devices/ocp.3/helper.11#</a> cat AIN4<br>
    0<br>
    <a class="moz-txt-link-abbreviated" href="mailto:root@rbone:/sys/devices/ocp.3/helper.11#">root@rbone:/sys/devices/ocp.3/helper.11#</a> cat AIN4<br>
    1460<br>
    <br>
    <div class="moz-cite-prefix">On 3/30/2014 9:16 AM, Zubair Lutfullah
      wrote:<br>
    </div>
    <blockquote
cite="mid:CAExKytzRv4CT9zTor=-fc5Mfv+xG9uTjQP=LWosVnhEHsa9Y0A@mail.gmail.com"
      type="cite">
      <div dir="ltr">
        <div><a moz-do-not-send="true"
href="https://github.com/beagleboard/kernel/blob/3.8/patches/adc/0017-IIO-ADC-ti_adc-Fix-1st-sample-read.patch">https://github.com/beagleboard/kernel/blob/3.8/patches/adc/0017-IIO-ADC-ti_adc-Fix-1st-sample-read.patch</a><br>
        </div>
        IIRC, this patch fixes this issue<br>
        <br>
        <div class="gmail_extra">Can you compile the kernel from the
          sources and check?<br>
          <a moz-do-not-send="true"
            href="https://github.com/beagleboard/kernel/tree/3.8">https://github.com/beagleboard/kernel/tree/3.8</a><br>
          <br>
          Regards<br>
        </div>
        <div class="gmail_extra">ZubairLK<br>
        </div>
        <div class="gmail_extra"><br>
          <div class="gmail_quote">On Sun, Mar 30, 2014 at 7:04 AM, Rob
            Mosher <span dir="ltr">&lt;<a moz-do-not-send="true"
                href="mailto:nyt@countercultured.net" target="_blank">nyt@countercultured.net</a>&gt;</span>
            wrote:<br>
            <blockquote class="gmail_quote" style="margin:0px 0px 0px
              0.8ex;border-left:1px solid
              rgb(204,204,204);padding-left:1ex">Just a note, the same
              behavior persists with BB-ADC dtb and reading from
              in_voltage4_raw
              <div class="">
                <div class="h5"><br>
                  <br>
                  On 3/30/2014 12:30 AM, Rob Mosher wrote:<br>
                  <blockquote class="gmail_quote" style="margin:0px 0px
                    0px 0.8ex;border-left:1px solid
                    rgb(204,204,204);padding-left:1ex">
                    Hello fine developers,<br>
                    <br>
                    It seems I've stumbled upon a problem while
                    developing a full featured Ruby gem for the
                    Beaglebone.<br>
                    <br>
                    It seems a patch included in the beaglebone kernel
                    causes some issues while reading analog inputs.
                    &nbsp;Apparently the samples get backlogged by the number
                    of adc pins in use. &nbsp;I'm not sure which patch
                    exactly as there are a number that affect adc
                    buffering and I'm not currently setup for kernel
                    building, however the below output should detail the
                    problem.<br>
                    <br>
                    Using the official Debian image.<br>
                    Linux rbone 3.8.13-bone43 #1 SMP Wed Mar 26 14:21:39
                    UTC 2014 armv7l GNU/Linux<br>
                    <br>
                    Distributor ID: Debian<br>
                    Description: &nbsp; &nbsp;Debian GNU/Linux 7.4 (wheezy)<br>
                    Release: &nbsp; &nbsp; &nbsp; &nbsp;7.4<br>
                    Codename: &nbsp; &nbsp; &nbsp; wheezy<br>
                    <br>
                    root@rbone:~# echo cape-bone-iio &gt;
                    /sys/devices/bone_capemgr.9/slots<br>
                    <br>
                    This is the normal and expected behavior.<br>
                    <br>
                    1.8v applied to AIN4<br>
                    <a class="moz-txt-link-abbreviated" href="mailto:root@rbone:/sys/devices/ocp.3/helper.12#">root@rbone:/sys/devices/ocp.3/helper.12#</a> cat AIN4<br>
                    1798<br>
                    <br>
                    0v applied to AIN4<br>
                    <a class="moz-txt-link-abbreviated" href="mailto:root@rbone:/sys/devices/ocp.3/helper.12#">root@rbone:/sys/devices/ocp.3/helper.12#</a> cat AIN4<br>
                    0<br>
                    <br>
                    1.8v applied to AIN4<br>
                    <a class="moz-txt-link-abbreviated" href="mailto:root@rbone:/sys/devices/ocp.3/helper.12#">root@rbone:/sys/devices/ocp.3/helper.12#</a> cat AIN4<br>
                    1798<br>
                    <br>
                    0v applied to AIN4<br>
                    <a class="moz-txt-link-abbreviated" href="mailto:root@rbone:/sys/devices/ocp.3/helper.12#">root@rbone:/sys/devices/ocp.3/helper.12#</a> cat AIN4<br>
                    0<br>
                    <br>
                    So far working as intended.... &nbsp;Now reading from the
                    other pins.<br>
                    <br>
                    <a class="moz-txt-link-abbreviated" href="mailto:root@rbone:/sys/devices/ocp.3/helper.12#">root@rbone:/sys/devices/ocp.3/helper.12#</a> grep .
                    AIN[0-3] AIN[5-7]<br>
                    AIN0:1563<br>
                    AIN1:1221<br>
                    AIN2:1487<br>
                    AIN3:789<br>
                    AIN5:514<br>
                    AIN6:743<br>
                    AIN7:1698<br>
                    <br>
                    Now applying 1.8v to AIN4<br>
                    <a class="moz-txt-link-abbreviated" href="mailto:root@rbone:/sys/devices/ocp.3/helper.12#">root@rbone:/sys/devices/ocp.3/helper.12#</a> cat AIN4<br>
                    0<br>
                    <a class="moz-txt-link-abbreviated" href="mailto:root@rbone:/sys/devices/ocp.3/helper.12#">root@rbone:/sys/devices/ocp.3/helper.12#</a> cat AIN4<br>
                    0<br>
                    <a class="moz-txt-link-abbreviated" href="mailto:root@rbone:/sys/devices/ocp.3/helper.12#">root@rbone:/sys/devices/ocp.3/helper.12#</a> cat AIN4<br>
                    0<br>
                    <a class="moz-txt-link-abbreviated" href="mailto:root@rbone:/sys/devices/ocp.3/helper.12#">root@rbone:/sys/devices/ocp.3/helper.12#</a> cat AIN4<br>
                    0<br>
                    <a class="moz-txt-link-abbreviated" href="mailto:root@rbone:/sys/devices/ocp.3/helper.12#">root@rbone:/sys/devices/ocp.3/helper.12#</a> cat AIN4<br>
                    0<br>
                    <a class="moz-txt-link-abbreviated" href="mailto:root@rbone:/sys/devices/ocp.3/helper.12#">root@rbone:/sys/devices/ocp.3/helper.12#</a> cat AIN4<br>
                    0<br>
                    <a class="moz-txt-link-abbreviated" href="mailto:root@rbone:/sys/devices/ocp.3/helper.12#">root@rbone:/sys/devices/ocp.3/helper.12#</a> cat AIN4<br>
                    1798<br>
                    <br>
                    Now applying 0v to AIN4<br>
                    <br>
                    <a class="moz-txt-link-abbreviated" href="mailto:root@rbone:/sys/devices/ocp.3/helper.12#">root@rbone:/sys/devices/ocp.3/helper.12#</a> cat AIN4<br>
                    1460<br>
                    <a class="moz-txt-link-abbreviated" href="mailto:root@rbone:/sys/devices/ocp.3/helper.12#">root@rbone:/sys/devices/ocp.3/helper.12#</a> cat AIN4<br>
                    1798<br>
                    <a class="moz-txt-link-abbreviated" href="mailto:root@rbone:/sys/devices/ocp.3/helper.12#">root@rbone:/sys/devices/ocp.3/helper.12#</a> cat AIN4<br>
                    1798<br>
                    <a class="moz-txt-link-abbreviated" href="mailto:root@rbone:/sys/devices/ocp.3/helper.12#">root@rbone:/sys/devices/ocp.3/helper.12#</a> cat AIN4<br>
                    1460<br>
                    <a class="moz-txt-link-abbreviated" href="mailto:root@rbone:/sys/devices/ocp.3/helper.12#">root@rbone:/sys/devices/ocp.3/helper.12#</a> cat AIN4<br>
                    1460<br>
                    <a class="moz-txt-link-abbreviated" href="mailto:root@rbone:/sys/devices/ocp.3/helper.12#">root@rbone:/sys/devices/ocp.3/helper.12#</a> cat AIN4<br>
                    1460<br>
                    <a class="moz-txt-link-abbreviated" href="mailto:root@rbone:/sys/devices/ocp.3/helper.12#">root@rbone:/sys/devices/ocp.3/helper.12#</a> cat AIN4<br>
                    0<br>
                    <br>
                    <br>
                    <br>
                    And another example, showing relation to the number
                    of pins in use.<br>
                    <br>
                    1.8v to AIN4<br>
                    <a class="moz-txt-link-abbreviated" href="mailto:root@rbone:/sys/devices/ocp.3/helper.12#">root@rbone:/sys/devices/ocp.3/helper.12#</a> cat AIN4<br>
                    1460<br>
                    <a class="moz-txt-link-abbreviated" href="mailto:root@rbone:/sys/devices/ocp.3/helper.12#">root@rbone:/sys/devices/ocp.3/helper.12#</a> grep .
                    AIN[0-3]<br>
                    AIN0:1697<br>
                    AIN1:1298<br>
                    AIN2:1524<br>
                    AIN3:816<br>
                    <a class="moz-txt-link-abbreviated" href="mailto:root@rbone:/sys/devices/ocp.3/helper.12#">root@rbone:/sys/devices/ocp.3/helper.12#</a> cat AIN4<br>
                    1798<br>
                    <br>
                    0v to AIN4<br>
                    <a class="moz-txt-link-abbreviated" href="mailto:root@rbone:/sys/devices/ocp.3/helper.12#">root@rbone:/sys/devices/ocp.3/helper.12#</a> cat AIN4<br>
                    1798<br>
                    <a class="moz-txt-link-abbreviated" href="mailto:root@rbone:/sys/devices/ocp.3/helper.12#">root@rbone:/sys/devices/ocp.3/helper.12#</a> cat AIN4<br>
                    1460<br>
                    <a class="moz-txt-link-abbreviated" href="mailto:root@rbone:/sys/devices/ocp.3/helper.12#">root@rbone:/sys/devices/ocp.3/helper.12#</a> cat AIN4<br>
                    1460<br>
                    <a class="moz-txt-link-abbreviated" href="mailto:root@rbone:/sys/devices/ocp.3/helper.12#">root@rbone:/sys/devices/ocp.3/helper.12#</a> cat AIN4<br>
                    1460<br>
                    <a class="moz-txt-link-abbreviated" href="mailto:root@rbone:/sys/devices/ocp.3/helper.12#">root@rbone:/sys/devices/ocp.3/helper.12#</a> cat AIN4<br>
                    0<br>
                    <br>
                    1.8v to AIN4<br>
                    <a class="moz-txt-link-abbreviated" href="mailto:root@rbone:/sys/devices/ocp.3/helper.12#">root@rbone:/sys/devices/ocp.3/helper.12#</a> cat AIN4<br>
                    0<br>
                    <a class="moz-txt-link-abbreviated" href="mailto:root@rbone:/sys/devices/ocp.3/helper.12#">root@rbone:/sys/devices/ocp.3/helper.12#</a> cat AIN4<br>
                    0<br>
                    <a class="moz-txt-link-abbreviated" href="mailto:root@rbone:/sys/devices/ocp.3/helper.12#">root@rbone:/sys/devices/ocp.3/helper.12#</a> cat AIN4<br>
                    0<br>
                    <a class="moz-txt-link-abbreviated" href="mailto:root@rbone:/sys/devices/ocp.3/helper.12#">root@rbone:/sys/devices/ocp.3/helper.12#</a> cat AIN4<br>
                    0<br>
                    <a class="moz-txt-link-abbreviated" href="mailto:root@rbone:/sys/devices/ocp.3/helper.12#">root@rbone:/sys/devices/ocp.3/helper.12#</a> cat AIN4<br>
                    1798<br>
                    <br>
                    -- <br>
                    Rob Mosher<br>
                    Senior Network and Software Engineer<br>
                    Hurricane Electric / AS6939<br>
                    <br>
                    <br>
                    <br>
                  </blockquote>
                  <br>
                </div>
              </div>
            </blockquote>
          </div>
          <br>
        </div>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------060902080204030809050302--
